# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    sequence(:name) { |n| "#{Faker::App.name} #{n}" }
  end
end
