# frozen_string_literal: true

module Search
  class Service
    def initialize(metrics_service: Metrics::Service.new)
      @metrics_service = metrics_service
    end

    # @param [String] model. Supported models [Metric]
    # @param [Array<String>] ids
    def bulk_index(model, ids)
      case model
      when 'Metric'
        metrics_service.find_by_ids(ids).reindex
      else
        raise UnsupportedModelForIndexingError
      end
    end

    private

    attr_reader :metrics_service
  end

  class UnsupportedModelForIndexingError < StandardError
  end

  class UnsupportedIndexingOperationError < StandardError
  end
end
