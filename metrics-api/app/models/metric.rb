# frozen_string_literal: true

class Metric < ApplicationRecord
  searchkick mappings: {
    properties: {
      name: { type: 'text', fielddata: true }
    }
  }
  belongs_to :application

  validates :name, presence: true
  validates :value, presence: true, numericality: true
  validates :timestamp, presence: true
  validate :timestamp_must_be_unix_time

  private

  def timestamp_must_be_unix_time
    return if timestamp.is_a?(Numeric) && timestamp >= 0

    errors.add(:your_timestamp, 'must be a non-negative number representing Unix time')
  end

  # Used by searchkick as the "search data" we are interested in
  def search_data
    {
      name: name,
      value: value,
      application_id: application.id,
      timestamp: Time.at(timestamp).utc
    }
  end
end
