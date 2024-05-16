# frozen_string_literal: true

module Metrics
  class Service
    BATCH_SIZE = 100

    # @param [Applications::Service] application_service
    def initialize(application_service: Applications::Service.new)
      @application_service = application_service
    end

    # @param [String] application_id
    # @param [Array<Hash>] metrics. Array of hashes with these keys [name value timestamp]
    def create_metrics_async(application_id, metrics)
      application_service.validate_registered_application!(application_id)

      enqueue_metrics_creation_job(application_id, metrics)
    end

    # @param [String] application_id
    # @param [Array<Hash>] metrics. Array of hashes with these keys [name value timestamp]
    def create_metrics(application_id, metrics)
      application_service.validate_registered_application!(application_id)

      validate_metrics!(application_id, metrics)

      inserted_ids = bulk_insert_metrics(application_id, metrics)

      index_newly_inserted_data(inserted_ids)
    end

    # @param [Array<String>] ids
    def find_by_ids(ids)
      Metric.where(id: ids)
    end

    private

    attr_reader :application_service

    def validate_metrics!(application_id, metrics)
      return if metrics.all? do |metric|
        Metric.new(**metric, application_id: application_id).valid?
      end

      raise ::Metrics::Service::InvalidMetricsRequestPayload
    end

    def enqueue_metrics_creation_job(application_id, metrics)
      metrics.each_slice(BATCH_SIZE) do |batch|
        CreateMetricsJob.perform_async(
          application_id, { batch: batch }.to_json
        )
      end
    end

    def bulk_insert_metrics(application_id, metrics)
      metrics_payload = metrics.map do |metric|
        Metric.new(
          application_id: application_id,
          id: ULID.generate,
          **metric
        )
      end

      result = Metric.import metrics_payload, returning: :id
      decode_binary_ids(result.ids)
    end

    # Active import is returning the binary format of the ulids, making them not usable for
    #  for future queries, so we need to convert them to readable format.
    def decode_binary_ids(ids)
      ids.map { |id| [id.to_s.gsub('\\x', '')].pack('H*').force_encoding('UTF-8') }
    end

    def index_newly_inserted_data(inserted_ids)
      inserted_ids.each_slice(BATCH_SIZE) do |ids_batch|
        IndexerJob.perform_async(
          'index',
          'Metric',
          ids_batch
        )
      end
    end

    class InvalidMetricsRequestPayload < StandardError
    end
  end
end
