# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_514_164_409) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'applications', id: :binary, force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'metrics', id: :binary, force: :cascade do |t|
    t.string 'name'
    t.bigint 'value'
    t.bigint 'timestamp'
    t.binary 'application_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['application_id'], name: 'index_metrics_on_application_id'
  end

  add_foreign_key 'metrics', 'applications'
end
