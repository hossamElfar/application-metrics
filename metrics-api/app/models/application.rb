# frozen_string_literal: true

class Application < ApplicationRecord
  has_many :metrics

  validates :name, presence: true, uniqueness: true
end
