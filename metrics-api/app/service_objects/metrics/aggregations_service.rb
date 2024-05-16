# frozen_string_literal: true

module Metrics
  class AggregationsService
    # @param [String] application_id
    def metrics_list_aggregated(application_id)
      query = {
        size: 0,
        query: {
          **filter_by_application_id(application_id)
        },
        aggs: {
          group_by_key: {
            terms: {
              field: 'name'
            },
            aggs: {
              **p_50_agg,
              **p95_agg,
              **p99_agg,
              **avg_agg
            }
          }
        }
      }
      elasticsearch_result = Metric.search(body: query).response

      parse_aggregation_bucket(
        elasticsearch_result['aggregations']['group_by_key']['buckets']
      )
    end

    # @param [String] application_id
    # @param [String] metric_name
    # @param [String] duration. Valid values [minute hour day week month quarter year]
    def metric_histogram_aggregation(application_id, metric_name, duration)
      query = {
        size: 0,
        query: {
          bool: {
            must: [
              filter_by_application_id(application_id),
              filter_by_metric_name(metric_name)
            ]
          }
        },
        aggs: {
          date_histogram_aggregation: {
            date_histogram: {
              field: 'timestamp',
              interval: duration
            },
            aggs: {
              **p_50_agg,
              **p95_agg,
              **p99_agg,
              **avg_agg
            }
          }
        }
      }
      elasticsearch_result = Metric.search(body: query).response

      parse_date_histogram_aggregation(
        elasticsearch_result['aggregations']['date_histogram_aggregation']['buckets']
      )
    end

    private

    def filter_by_application_id(application_id)
      {
        match: {
          application_id: application_id
        }
      }
    end

    def filter_by_metric_name(metric_name)
      {
        match: {
          name: metric_name
        }
      }
    end

    def p_50_agg
      {
        p50: {
          percentiles: {
            field: 'value',
            percents: [50]
          }
        }
      }
    end

    def p95_agg
      {
        p95: {
          percentiles: {
            field: 'value',
            percents: [95]
          }
        }
      }
    end

    def p99_agg
      {
        p99: {
          percentiles: {
            field: 'value',
            percents: [99]
          }
        }
      }
    end

    def avg_agg
      {
        avg: {
          avg: {
            field: 'value'
          }
        }
      }
    end

    def parse_aggregation_bucket(buckets)
      buckets.map do |bucket|
        {
          metric_name: bucket['key'],
          p99: bucket['p99']['values']['99.0'],
          p95: bucket['p95']['values']['95.0'],
          p50: bucket['p50']['values']['50.0'],
          avg: bucket['avg']['value']
        }
      end
    end

    def parse_date_histogram_aggregation(buckets)
      buckets.map do |bucket|
        {
          date: bucket['key_as_string'],
          count: bucket['doc_count'],
          p99: bucket['p99']['values']['99.0'],
          p95: bucket['p95']['values']['95.0'],
          p50: bucket['p50']['values']['50.0'],
          avg: bucket['avg']['value']
        }
      end
    end
  end
end
