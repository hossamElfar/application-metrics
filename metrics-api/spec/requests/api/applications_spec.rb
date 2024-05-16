# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/applications' do
  let!(:applications) do
    create_list(:application, 2) do |application, i|
      application.name = "#{application.name} #{i}"
    end
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_applications_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_application_url(applications.first), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    let(:attributes) do
      {
        name: 'Test app 3'
      }
    end

    it 'creates a new Application' do
      expect do
        post api_v1_applications_url,
             params: { application: attributes }, as: :json
      end.to change(Application, :count).by(1)
    end
  end
end
