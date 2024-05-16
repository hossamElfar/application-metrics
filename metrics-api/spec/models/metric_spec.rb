# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Metric do
  describe 'validations' do
    subject { build(:metric) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:timestamp) }
  end
end
