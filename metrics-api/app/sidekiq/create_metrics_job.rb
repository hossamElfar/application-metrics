# frozen_string_literal: true

class CreateMetricsJob
  include Sidekiq::Job

  # @param [String] application_id
  # @param [String] metrics
  def perform(application_id, metrics)
    metrics_service = Metrics::Service.new
    parsed_batch = JSON.parse(metrics).with_indifferent_access

    metrics_service.create_metrics(
      application_id, parsed_batch[:batch]
    )
  end
end
