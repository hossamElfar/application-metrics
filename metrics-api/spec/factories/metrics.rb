# frozen_string_literal: true

FactoryBot.define do
  factory :metric do
    application
    name { Faker::Internet.username }
    value { rand(1..100_000) }
    # Random timestamp from the last year
    timestamp { Faker::Time.backward(days: 365 * 2).to_i }
  end
end
