# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cache::Keys do
  describe '.registered_applications_list' do
    it { expect(described_class.registered_applications_list).to eq 'registered_applications' }
  end
end
