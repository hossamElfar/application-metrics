# frozen_string_literal: true

module Api
  module V1
    class MetricsController < ApplicationController
      # GET api/v1/applications/:application_id/metrics
      def index
        render json: metrics_aggregations_service.metrics_list_aggregated(
          params[:application_id]
        )
      end

      # GET /api/v1/applications/:application_id/metrics/:id
      def show
        validate_duration!

        render json: metrics_aggregations_service.metric_histogram_aggregation(
          # params[:id] is the metric identifier, in our case is the metric name.
          params[:application_id], params[:id], params[:duration]
        )
      end

      # POST /api/v1/applications/:application_id/metrics
      def create
        metrics_service.create_metrics_async(
          params[:application_id], create_metrics_params
        )
        render json: {}, status: :created
      end

      private

      def metrics_service
        @metrics_service ||= Metrics::Service.new
      end

      def metrics_aggregations_service
        @metrics_aggregations_service ||= Metrics::AggregationsService.new
      end

      def create_metrics_params
        params.permit(metrics: %i[name value timestamp])[:metrics].map(&:to_h)
      end

      def validate_duration!
        duration = params[:duration]
        return if %w[minute hour day week month quarter year].include?(duration)

        raise ArgumentError, 'unsupported duration type'
      end
    end
  end
end
