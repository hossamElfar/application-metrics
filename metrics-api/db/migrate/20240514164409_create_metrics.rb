# frozen_string_literal: true

class CreateMetrics < ActiveRecord::Migration[7.1]
  def change
    create_table :metrics, id: false do |t|
      t.binary :id, limit: 16, primary_key: true
      t.string :name
      t.bigint :value
      t.bigint :timestamp
      t.references :application, type: :binary, foreign_key: true, index: true

      t.timestamps
    end
  end
end
