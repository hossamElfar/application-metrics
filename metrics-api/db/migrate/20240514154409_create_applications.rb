# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications, id: false do |t|
      t.binary :id, limit: 16, primary_key: true
      t.string :name

      t.timestamps
    end
  end
end
