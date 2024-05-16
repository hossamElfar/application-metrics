# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Application do
  describe 'validations' do
    subject { build(:application) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
