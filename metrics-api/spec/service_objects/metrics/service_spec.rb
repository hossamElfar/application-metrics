# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metrics::Service do
  subject(:service) { described_class.new(application_service: application_service) }

  let(:application_service) { instance_double(Applications::Service) }

  describe '#find_by_ids' do
    let!(:metrics) { create_list(:metric, 3) }

    context 'when metric exists' do
      it 'returns the correct metrics' do
        result = service.find_by_ids(metrics.take(2).map(&:id))
        expect(result.size).to eq 2
      end
    end
  end

  describe '#create_metrics_async' do
    let(:application_id) { 'ID1' }
    let(:metrics_payload) do
      [
        {
          name: 'metric1',
          value: 10,
          timestamp: Time.now.to_i
        },
        {
          name: 'metric2',
          value: 20,
          timestamp: Time.now.to_i
        },
        {
          name: 'metric3',
          value: 30,
          timestamp: Time.now.to_i
        }
      ]
    end
    let(:valid_application) { true }

    before do
      allow(application_service).to receive(:validate_registered_application!).and_return(valid_application)
      allow(CreateMetricsJob).to receive(:perform_async)
    end

    context 'when application is registered' do
      it 'enqueues a job to insert the metrics async' do
        service.create_metrics_async(application_id, metrics_payload)

        expect(CreateMetricsJob).to have_received(:perform_async).with(application_id,
                                                                       { batch: metrics_payload }.to_json)
      end
    end

    context 'when application is not registered' do
      before do
        allow(application_service).to receive(:validate_registered_application!)
          .and_raise(Applications::Service::ApplicationNotRegisteredError)
      end

      it 'does not enqueue a job to insert the metrics async' do
        expect do
          service.create_metrics_async(application_id,
                                       metrics_payload)
        end.to raise_error(Applications::Service::ApplicationNotRegisteredError)
        expect(CreateMetricsJob).not_to have_received(:perform_async)
      end
    end
  end

  describe '#create_metrics' do
    let!(:application) { create(:application) }
    let(:application_id) { application.id }
    let(:metrics_payload) do
      [
        {
          name: 'metric1',
          value: 10,
          timestamp: Time.now.to_i
        },
        {
          name: 'metric2',
          value: 20,
          timestamp: Time.now.to_i
        },
        {
          name: 'metric3',
          value: 30,
          timestamp: Time.now.to_i
        }
      ]
    end
    let(:valid_application) { true }

    before do
      allow(application_service).to receive(:validate_registered_application!).and_return(valid_application)
      allow(IndexerJob).to receive(:perform_async)
    end

    context 'when application is registered' do
      it 'creates metrics and enqueues a bulk indexing job' do
        expect do
          service.create_metrics(application_id, metrics_payload)
        end.to change(Metric, :count).by(3)

        expect(IndexerJob).to have_received(:perform_async).once
      end
    end

    context 'when application is not registered' do
      before do
        allow(application_service).to receive(:validate_registered_application!)
          .and_raise(Applications::Service::ApplicationNotRegisteredError)
      end

      it 'does not create metrics' do
        expect do
          service.create_metrics(application_id, metrics_payload)
        end.to raise_error(Applications::Service::ApplicationNotRegisteredError)

        expect(IndexerJob).not_to have_received(:perform_async)
      end
    end
  end
end
