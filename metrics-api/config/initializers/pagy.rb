# frozen_string_literal: true

require 'pagy/extras/jsonapi'
require 'pagy/extras/metadata'

Pagy::DEFAULT[:items] = 10
Pagy::DEFAULT[:jsonapi] = true
