# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include UlidPk
  primary_abstract_class
end
