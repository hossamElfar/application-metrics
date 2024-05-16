# frozen_string_literal: true

module Cache
  class Service
    # @param [String] application_id
    def add_registered_application(application_id)
      REDIS.sadd(
        Cache::Keys.registered_applications_list,
        application_id
      )
    end

    # @param [String] application_id
    def registered_application?(application_id)
      REDIS.sismember(
        Cache::Keys.registered_applications_list,
        application_id
      )
    end
  end
end
