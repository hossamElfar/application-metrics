# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      respond(:record_not_found, 404, e.to_s)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      respond(:record_invalid, 422, e.to_s)
    end

    rescue_from ActiveRecord::ActiveRecordError do |e|
      respond(:record_invalid, 422, e.to_s)
    end

    rescue_from Applications::Service::ApplicationNotRegisteredError do |e|
      respond(:application_does_not_exist, 400, e.to_s)
    end

    rescue_from Metrics::Service::InvalidMetricsRequestPayload do |e|
      respond(:invalid_metrics_data, 400, e.to_s)
    end

    rescue_from ArgumentError do |e|
      respond(:invalid_argument, 400, e.to_s)
    end

    rescue_from StandardError do |e|
      respond(:standard_error, 500, e.to_s)
    end
  end

  private

  def respond(error, status, message)
    render json: {
      message: message,
      error: error
    }, status: status
  end
end
