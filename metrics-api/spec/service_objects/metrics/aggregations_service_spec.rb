# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metrics::AggregationsService do
  subject(:service) { described_class.new }

  let!(:application) { create(:application) }

  before do
    Timecop.freeze(Time.utc(2024, 5, 15, 12, 0, 0))
  end

  after do
    Timecop.return
  end

  describe '#metrics_list_aggregated' do
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

    it 'returns the metrics grouped and aggregated' do
      result = service.metrics_list_aggregated(application.id)

      expect(result).to eq expected
    end
  end

  describe '#metric_histogram_aggregation' do
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

    let(:duration) { 'day' }

    before do
      Metric.search_index.delete
      Metric.reindex
    end

    context 'when duration is day' do
      let(:duration) { 'day' }
      let(:expected) do
        [
          { date: '2024-05-08T00:00:00.000Z', count: 1, p99: 3.0, p95: 3.0, p50: 3.0, avg: 3.0 },
          { date: '2024-05-09T00:00:00.000Z', count: 0, p99: nil, p95: nil, p50: nil, avg: nil },
          { date: '2024-05-10T00:00:00.000Z', count: 1, p99: 5.0, p95: 5.0, p50: 5.0, avg: 5.0 },
          { date: '2024-05-11T00:00:00.000Z', count: 0, p99: nil, p95: nil, p50: nil, avg: nil },
          { date: '2024-05-12T00:00:00.000Z', count: 1, p99: 30.0, p95: 30.0, p50: 30.0, avg: 30.0 },
          { date: '2024-05-13T00:00:00.000Z', count: 2, p99: 20.0, p95: 20.0, p50: 17.5, avg: 17.5 },
          { date: '2024-05-14T00:00:00.000Z', count: 1, p99: 10.0, p95: 10.0, p50: 10.0, avg: 10.0 }
        ]
      end

      it 'returns the metrics grouped and aggregated' do
        result = service.metric_histogram_aggregation(application.id, 'awesome1', duration)

        expect(result).to eq(expected)
      end
    end

    context 'when duration is week' do
      let(:duration) { 'week' }
      let(:expected) do
        [
          { date: '2024-05-06T00:00:00.000Z', count: 3, p99: 30.0, p95: 30.0, p50: 5.0, avg: 12.666666666666666 },
          { date: '2024-05-13T00:00:00.000Z', count: 3, p99: 20.0, p95: 20.0, p50: 15.0, avg: 15.0 }
        ]
      end

      it 'returns the metrics grouped and aggregated' do
        result = service.metric_histogram_aggregation(application.id, 'awesome1', duration)

        expect(result).to eq(expected)
      end
    end

    context 'when duration is month' do
      let(:duration) { 'month' }
      let(:expected) do
        [
          { date: '2024-05-01T00:00:00.000Z', count: 6, p99: 30.0, p95: 30.0, p50: 12.5, avg: 13.833333333333334 }
        ]
      end

      it 'returns the metrics grouped and aggregated' do
        result = service.metric_histogram_aggregation(application.id, 'awesome1', duration)

        expect(result).to eq(expected)
      end
    end
  end
end
