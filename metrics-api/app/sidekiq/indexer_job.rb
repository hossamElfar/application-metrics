# frozen_string_literal: true

class IndexerJob
  include Sidekiq::Job

  # @param [String] action. Supported action is index
  # @param [String] model. Supported models [Metric]
  # @param [Array<String>] ids
  def perform(action, model, ids)
    case action
    when 'index'
      Search::Service.new.bulk_index(model, ids)
    else
      raise Search::UnsupportedIndexingOperationError
    end
  end
end
