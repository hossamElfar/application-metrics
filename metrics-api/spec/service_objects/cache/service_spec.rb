# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cache::Service do
  subject(:service) { described_class.new }

  describe '#add_registered_application' do
    let(:application_id) { 'ID1' }

    it 'adds the application id to the registered apps set' do
      service.add_registered_application(application_id)
      expect(REDIS.sismember('registered_applications', application_id)).to be_truthy
    end
  end

  describe '#registered_application?' do
    let(:application_id) { 'ID1' }

    context 'when application id belongs to the registered applications list' do
      before do
        REDIS.sadd('registered_applications', application_id)
      end

      it 'returns true' do
        expect(service).to be_registered_application(application_id)
      end
    end

    context 'when application id does not belong to the registered applications list' do
      it 'returns true' do
        expect(service).not_to be_registered_application(application_id)
      end
    end
  end
end
