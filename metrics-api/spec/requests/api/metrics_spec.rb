# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/metrics' do
  let!(:application) { create(:application) }

  let(:parsed_response_body) do
    JSON.parse(response.body, symbolize_names: true)
  end

  describe 'GET /metrics' do
    let!(:metric_1) { create(:metric, name: 'awesome1', value: 10, timestamp: Time.now.to_i, application: application) }
    let!(:metric_2) { create(:metric, name: 'awesome1', value: 15, timestamp: Time.now.to_i, application: application) }
    let!(:metric_3) { create(:metric, name: 'awesome1', value: 20, timestamp: Time.now.to_i, application: application) }
    let!(:metric_4) { create(:metric, name: 'awesome2', value: 5, timestamp: Time.now.to_i, application: application) }
    let!(:metric_5) { create(:metric, name: 'awesome2', value: 3, timestamp: Time.now.to_i, application: application) }
    let!(:metric_6) { create(:metric, name: 'awesome3', value: 30, timestamp: Time.now.to_i, application: application) }

    let(:expected) do
      [
        { metric_name: 'awesome1', p99: 20.0, p95: 20.0, p50: 15.0, avg: 15.0 },
        { metric_name: 'awesome2', p99: 5.0, p95:  5.0, p50: 4.0, avg: 4.0 },
        { metric_name: 'awesome3', p99: 30.0, p95: 30.0, p50: 30.0, avg: 30.0 }
      ]
    end

    before do
      Metric.search_index.delete
      Metric.reindex
    end

    it 'returns the correct response' do
      get api_v1_application_metrics_url(application_id: application.id), as: :json

      expect(parsed_response_body).to eq expected
    end
  end

  describe 'GET /metrics/:name' do
    let!(:metric_1) do
      create(:metric, name: 'awesome1', value: 10, timestamp: 1.day.ago.to_i, application: application)
    end
    let!(:metric_2) do
      create(:metric, name: 'awesome1', value: 15, timestamp: 2.days.ago.to_i, application: application)
    end
    let!(:metric_3) do
      create(:metric, name: 'awesome1', value: 20, timestamp: 2.days.ago.to_i, application: application)
    end
    let!(:metric_4) do
      create(:metric, name: 'awesome1', value: 5, timestamp: 5.days.ago.to_i, application: application)
    end
    let!(:metric_5) do
      create(:metric, name: 'awesome1', value: 3, timestamp: 1.week.ago.to_i, application: application)
    end
    let!(:metric_6) do
      create(:metric, name: 'awesome1', value: 30, timestamp: 3.days.ago.to_i, application: application)
    end
    let(:duration) { 'week' }
    let(:expected) do
      [
        { date: '2024-05-06T00:00:00.000Z', count: 3, p99: 30.0, p95: 30.0, p50: 5.0, avg: 12.666666666666666 },
        { date: '2024-05-13T00:00:00.000Z', count: 3, p99: 20.0, p95: 20.0, p50: 15.0, avg: 15.0 }
      ]
    end

    before do
      Timecop.freeze(Time.utc(2024, 5, 15, 12, 0, 0))
      Metric.search_index.delete
      Metric.reindex
    end

    after do
      Timecop.return
    end

    it 'returns the correct response' do
      get api_v1_application_metric_url(application_id: application.id, id: 'awesome1', duration: duration), as: :json
      expect(parsed_response_body).to eq expected
    end
  end

  describe 'POST /metrics' do
    let(:params) do
      {
        metrics: [
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
      }
    end

    before do
      Cache::Service.new.add_registered_application(application.id)
      allow(CreateMetricsJob).to receive(:perform_async)
    end

    it 'enqueues a job to create metrics async' do
      post api_v1_application_metrics_url(application_id: application.id),
           params: params, as: :json

      expect(CreateMetricsJob).to have_received(:perform_async)
        .with(application.id, { batch: params[:metrics] }.to_json).once
    end
  end
end
