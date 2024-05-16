# frozen_string_literal: true

module Api
  module V1
    class ApplicationsController < ApplicationController
      before_action :set_application, only: %i[show]

      # GET api/v1/applications
      def index
        render json: applications_service.applications_paginated(
          page: params[:page] || 1
        )
      end

      # GET /api/v1/applications/:ulid
      def show
        render json: @application
      end

      # POST /api/v1/applications
      def create
        @application = applications_service.create_application(
          application_params
        )

        render json: @application, status: :created
      end

      private

      def applications_service
        @applications_service ||= Applications::Service.new
      end

      def set_application
        @application = applications_service.find_by_id(params[:id])
      end

      def application_params
        params.require(:application).permit(:name)
      end
    end
  end
end
