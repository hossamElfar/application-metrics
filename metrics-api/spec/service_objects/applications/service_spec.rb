# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Applications::Service do
  subject(:service) { described_class.new(cache_service: cache_service) }

  let(:cache_service) { instance_double(Cache::Service) }

  describe '#find_by_id' do
    let!(:application) { create(:application) }

    context 'when application exists' do
      it 'returns the correct application' do
        result = service.find_by_id(application.id)
        expect(result).not_to be_nil
        expect(result.name).to eq application.name
      end
    end

    context 'when application does not exist' do
      it 'raises record not found error' do
        expect { service.find_by_id('random_id') }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#applications_paginated' do
    let!(:applications) do
      create_list(:application, 2) do |application, i|
        application.name = "#{application.name} #{i}"
      end
    end

    it 'returns the applications paginated' do
      result = service.applications_paginated

      expect(result[:records].size).to eq applications.size
      expect(result[:meta]).to eq({
                                    page: 1,
                                    items: 10,
                                    count: 2
                                  })
    end

    context 'when the applications exceeds the page size' do
      let!(:applications) do
        create_list(:application, 20) do |application, i|
          application.name = "#{application.name} #{i}"
        end
      end

      it 'returns the list paginated' do
        result = service.applications_paginated

        expect(result[:records].size).to eq 10
        expect(result[:meta]).to eq({
                                      page: 1,
                                      items: 10,
                                      count: 20
                                    })
      end
    end
  end

  describe '#create_application' do
    let(:params) do
      {
        name: name
      }
    end
    let(:name) { 'Awesome App' }

    before do
      allow(cache_service).to receive(:add_registered_application)
    end

    context 'when create application params are valid' do
      it 'creates the application' do
        result = service.create_application(params)
        expect(result).not_to be_nil
        expect(cache_service).to have_received(:add_registered_application).once.with(result.id)
      end
    end

    context 'when the params are invalid' do
      let!(:existing_application) { create(:application, name: 'Existing App') }
      let(:name) { 'Existing App' }

      it 'raises record not valid' do
        expect { service.create_application(params) }.to raise_error(ActiveRecord::RecordInvalid)
        expect(cache_service).not_to have_received(:add_registered_application)
      end
    end
  end
end
