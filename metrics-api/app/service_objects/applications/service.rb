# frozen_string_literal: true

module Applications
  class Service
    include Pagy::Backend

    # @param [Cache::Service] cache_service
    def initialize(cache_service: Cache::Service.new)
      @cache_service = cache_service
    end

    # @param [String] id application id
    def find_by_id(id)
      Application.find(id)
    end

    # @param [Number] page, page number. Default2 to 1.
    def applications_paginated(page: 1)
      pagy, records = pagy(Application.all, { page: page || 1 })

      {
        records: records,
        meta: pagy.vars.slice(:page, :items, :count)
      }
    end

    # @param [ActionController::Params|Hash[name:[String]]] params.
    def create_application(params)
      application = Application.create!(params)
      cache_service.add_registered_application(application.id)

      application
    end

    # @param [String] application_id
    def validate_registered_application!(application_id)
      return if cache_service.registered_application?(application_id)

      raise Applications::Service::ApplicationNotRegisteredError
    end

    private

    attr_reader :cache_service

    class ApplicationNotRegisteredError < StandardError
    end
  end
end
