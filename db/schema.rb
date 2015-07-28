# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150728163906) do

  create_table "air_conditioner_answers", force: :cascade do |t|
    t.string   "name_ja",    limit: 255
    t.string   "name_en",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "air_conditioner_infos", force: :cascade do |t|
    t.integer  "railway_line_info_id"
    t.integer  "car_number"
    t.datetime "post_time"
    t.integer  "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "train_location_info_id"
  end

  create_table "barrier_free_facility_escalator_direction_infos", force: :cascade do |t|
    t.integer  "service_detail_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pattern_id"
  end

  create_table "barrier_free_facility_escalator_direction_patterns", force: :cascade do |t|
    t.boolean  "up"
    t.boolean  "down"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_infos", force: :cascade do |t|
    t.string   "id_urn",                      limit: 255
    t.string   "same_as",                     limit: 255
    t.integer  "station_facility_info_id"
    t.integer  "type_id"
    t.integer  "located_area_id"
    t.boolean  "is_available_to_wheel_chair"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "remark_id"
  end

  create_table "barrier_free_facility_located_areas", force: :cascade do |t|
    t.string   "name_ja",    limit: 255
    t.string   "name_en",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_place_names", force: :cascade do |t|
    t.string   "name_ja",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_remarks", force: :cascade do |t|
    t.string   "ja"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "barrier_free_facility_root_infos", force: :cascade do |t|
    t.integer  "info_id"
    t.integer  "place_name_id"
    t.integer  "index_in_root"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_service_detail_infos", force: :cascade do |t|
    t.integer  "info_id"
    t.integer  "pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_service_detail_patterns", force: :cascade do |t|
    t.integer  "operation_day_id"
    t.boolean  "service_start_before_first_train"
    t.integer  "service_start_time_hour"
    t.integer  "service_start_time_min"
    t.integer  "service_end_time_hour"
    t.integer  "service_end_time_min"
    t.boolean  "service_end_after_last_train"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_toilet_assistant_infos", force: :cascade do |t|
    t.integer  "info_id"
    t.integer  "pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_toilet_assistant_patterns", force: :cascade do |t|
    t.boolean  "wheel_chair_accessible"
    t.boolean  "baby_chair"
    t.boolean  "baby_changing_table"
    t.boolean  "ostomate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_types", force: :cascade do |t|
    t.string   "type",       limit: 255
    t.string   "name_ja",    limit: 255
    t.string   "name_en",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connecting_railway_line_infos", force: :cascade do |t|
    t.integer  "station_info_id"
    t.integer  "index_in_station"
    t.integer  "railway_line_info_id"
    t.integer  "connecting_station_info_id"
    t.boolean  "connecting_to_another_station"
    t.boolean  "cleared"
    t.boolean  "not_recommended"
    t.integer  "note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_on"
    t.boolean  "hidden_on_railway_line_page"
    t.datetime "end_on"
  end

  create_table "connecting_railway_line_notes", force: :cascade do |t|
    t.text     "ja"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "design_color_infos", force: :cascade do |t|
    t.string   "hex_color"
    t.string   "name_ja"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fare_infos", force: :cascade do |t|
    t.string   "same_as",              limit: 255
    t.integer  "from_station_info_id"
    t.integer  "to_station_info_id"
    t.integer  "operator_info_id"
    t.integer  "normal_group_id"
    t.string   "id_urn",               limit: 255
    t.datetime "dc_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fare_normal_groups", force: :cascade do |t|
    t.integer  "ticket_fare"
    t.integer  "child_ticket_fare"
    t.integer  "ic_card_fare"
    t.integer  "child_ic_card_fare"
    t.integer  "operator_info_id"
    t.date     "date_of_revision"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operation_days", force: :cascade do |t|
    t.string   "same_as",    limit: 255
    t.string   "name_ja",    limit: 255
    t.string   "name_en",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operator_as_train_owners", force: :cascade do |t|
    t.integer  "info_id"
    t.string   "same_as",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operator_code_infos", force: :cascade do |t|
    t.string   "code"
    t.string   "railway_line_code_shape"
    t.string   "railway_line_code_stroke_width_setting"
    t.string   "railway_line_code_text_weight"
    t.string   "railway_line_code_text_size_setting"
    t.string   "station_code_shape"
    t.string   "station_code_stroke_width_setting"
    t.string   "station_code_text_weight"
    t.string   "station_code_text_size_setting"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "numbering"
    t.integer  "info_id"
    t.integer  "color_info_id"
  end

  create_table "operator_infos", force: :cascade do |t|
    t.string   "name_ja",       limit: 255
    t.string   "name_hira",     limit: 255
    t.string   "name_en",       limit: 255
    t.float    "index"
    t.string   "same_as",       limit: 255
    t.string   "name_ja_short", limit: 255
    t.string   "name_en_short", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passenger_surveys", force: :cascade do |t|
    t.integer  "survey_year"
    t.integer  "station_info_id"
    t.integer  "operator_info_id"
    t.integer  "passenger_journeys"
    t.string   "same_as",            limit: 255
    t.string   "id_urn",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "point_additional_names", force: :cascade do |t|
    t.string   "ja"
    t.string   "en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_categories", force: :cascade do |t|
    t.string   "name_ja",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en"
  end

  create_table "point_codes", force: :cascade do |t|
    t.string   "main"
    t.integer  "additional_name_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "point_infos", force: :cascade do |t|
    t.string   "id_urn",                   limit: 255
    t.integer  "station_facility_info_id"
    t.integer  "category_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geojson",                  limit: 255
    t.integer  "floor"
    t.boolean  "elevator"
    t.boolean  "closed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "code_id"
  end

  create_table "railway_directions", force: :cascade do |t|
    t.string   "same_as",                limit: 255
    t.string   "in_api_same_as",         limit: 255
    t.integer  "railway_line_info_id"
    t.integer  "station_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "railway_direction_code", limit: 255
  end

  create_table "railway_line_additional_infos", force: :cascade do |t|
    t.integer  "info_id"
    t.string   "id_urn"
    t.datetime "dc_date"
    t.string   "geojson"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "api_info"
  end

  create_table "railway_line_code_infos", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "numbering"
    t.integer  "color_info_id"
    t.string   "code"
  end

  create_table "railway_line_info_code_infos", force: :cascade do |t|
    t.integer  "info_id"
    t.integer  "code_info_id"
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "index"
  end

  create_table "railway_line_infos", force: :cascade do |t|
    t.string   "name_ja",           limit: 255
    t.string   "name_hira",         limit: 255
    t.string   "name_en",           limit: 255
    t.integer  "operator_info_id"
    t.string   "same_as",           limit: 255
    t.float    "index_in_operator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_on"
    t.datetime "end_on"
  end

  create_table "railway_line_relations", force: :cascade do |t|
    t.integer  "main_railway_line_info_id"
    t.integer  "branch_railway_line_info_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "railway_line_travel_time_infos", force: :cascade do |t|
    t.integer  "railway_line_info_id"
    t.integer  "from_station_info_id"
    t.integer  "to_station_info_id"
    t.integer  "train_type_info_id"
    t.integer  "necessary_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "railway_line_women_only_car_infos", force: :cascade do |t|
    t.integer  "railway_line_info_id",      null: false
    t.integer  "from_station_info_id",      null: false
    t.integer  "to_station_info_id",        null: false
    t.integer  "operation_day_id",          null: false
    t.integer  "available_time_from_hour",  null: false
    t.integer  "available_time_from_min",   null: false
    t.integer  "available_time_until_hour", null: false
    t.integer  "available_time_until_min",  null: false
    t.integer  "car_composition",           null: false
    t.integer  "car_number",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "train_type_info_id"
  end

  create_table "rss_categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "feed_url",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rss_infos", force: :cascade do |t|
    t.string   "title",         limit: 255
    t.string   "url",           limit: 255
    t.string   "feed_url",      limit: 255
    t.string   "etag",          limit: 255
    t.datetime "last_modified"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_infos", force: :cascade do |t|
    t.string   "same_as",    limit: 255
    t.string   "id_urn",     limit: 255
    t.datetime "dc_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_name_aliases", force: :cascade do |t|
    t.integer  "station_facility_info_id"
    t.string   "same_as",                  limit: 255
    t.integer  "index_of_alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_barrier_free_facility_infos", force: :cascade do |t|
    t.integer  "platform_info_id"
    t.integer  "barrier_free_facility_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_infos", force: :cascade do |t|
    t.integer  "station_facility_info_id"
    t.integer  "car_composition"
    t.integer  "car_number"
    t.integer  "railway_line_info_id"
    t.integer  "railway_direction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_surrounding_areas", force: :cascade do |t|
    t.integer  "platform_info_id"
    t.integer  "surrounding_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_transfer_infos", force: :cascade do |t|
    t.integer  "platform_info_id"
    t.integer  "railway_line_info_id"
    t.integer  "railway_direction_id"
    t.integer  "necessary_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_infos", force: :cascade do |t|
    t.integer  "operator_info_id"
    t.string   "same_as",                       limit: 255
    t.integer  "railway_line_info_id"
    t.integer  "index_in_railway_line"
    t.string   "station_code",                  limit: 255
    t.integer  "station_facility_info_id"
    t.string   "name_ja",                       limit: 255
    t.string   "name_hira",                     limit: 255
    t.string   "name_en",                       limit: 255
    t.string   "name_in_system",                limit: 255
    t.string   "id_urn",                        limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "station_name_alias",            limit: 255
    t.string   "station_facility_custom",       limit: 255
    t.string   "station_facility_custom_alias", limit: 255
    t.datetime "dc_date"
    t.string   "geojson",                       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_name_aliases", force: :cascade do |t|
    t.integer  "station_info_id"
    t.string   "same_as",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_passenger_surveys", force: :cascade do |t|
    t.integer  "station_info_id"
    t.integer  "passenger_survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_points", force: :cascade do |t|
    t.integer  "station_info_id"
    t.integer  "point_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_stopping_pattern_infos", force: :cascade do |t|
    t.integer  "station_info_id"
    t.integer  "stopping_pattern_id"
    t.boolean  "partial"
    t.boolean  "for_driver"
    t.integer  "note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_stopping_pattern_notes", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetable_connection_infos", force: :cascade do |t|
    t.integer  "station_info_id"
    t.string   "note",            limit: 255
    t.boolean  "connection"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetable_fundamental_infos", force: :cascade do |t|
    t.integer  "info_id",              null: false
    t.integer  "station_info_id",      null: false
    t.integer  "operator_info_id",     null: false
    t.integer  "railway_line_info_id", null: false
    t.integer  "railway_direction_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetable_infos", force: :cascade do |t|
    t.string   "id_urn",     limit: 255, null: false
    t.string   "same_as",    limit: 255, null: false
    t.datetime "dc_date",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetable_starting_station_infos", force: :cascade do |t|
    t.integer  "station_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_train_times", force: :cascade do |t|
    t.integer  "station_timetable_info_id"
    t.integer  "train_timetable_info_id"
    t.integer  "departure_station_info_id"
    t.integer  "departure_time_hour"
    t.integer  "departure_time_min"
    t.integer  "arrival_station_info_id"
    t.integer  "arrival_time_hour"
    t.integer  "arrival_time_min"
    t.boolean  "is_last"
    t.boolean  "is_origin"
    t.integer  "platform_number"
    t.integer  "station_timetable_starting_station_info_id"
    t.integer  "train_type_info_in_this_station_id"
    t.boolean  "stop_for_drivers"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "station_timetable_connection_info_id"
    t.integer  "index_in_train_timetable_info"
  end

  create_table "stopping_patterns", force: :cascade do |t|
    t.string   "same_as",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surrounding_areas", force: :cascade do |t|
    t.string   "name_ja",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_basenames", force: :cascade do |t|
    t.string   "name_ja"
    t.string   "name_hira"
    t.string   "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "train_location_infos", force: :cascade do |t|
    t.string   "id_urn",                     limit: 255
    t.string   "same_as",                    limit: 255
    t.datetime "dc_date"
    t.datetime "valid_until"
    t.integer  "frequency"
    t.string   "train_number",               limit: 255
    t.integer  "train_time_info_id"
    t.integer  "railway_line_info_id"
    t.integer  "operator_as_train_owner_id"
    t.integer  "from_station_info_id"
    t.integer  "to_station_info_id"
    t.integer  "railway_direction_id"
    t.integer  "delay"
    t.integer  "now_from"
    t.integer  "now_to"
    t.integer  "now_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "valid"
  end

  create_table "train_names", force: :cascade do |t|
    t.string   "same_as"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "train_basename_id"
    t.integer  "index"
  end

  create_table "train_operation_infos", force: :cascade do |t|
    t.string   "id_urn",               limit: 255
    t.datetime "dc_date"
    t.datetime "valid_until"
    t.integer  "operator_info_id"
    t.datetime "time_of_origin"
    t.integer  "railway_line_info_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "text_id"
    t.boolean  "valid"
  end

  create_table "train_operation_statuses", force: :cascade do |t|
    t.string   "name_ja",    limit: 255
    t.string   "name_en",    limit: 255
    t.string   "in_api",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_operation_texts", force: :cascade do |t|
    t.string   "in_api"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "train_relations", force: :cascade do |t|
    t.integer  "previous_train_timetable_info_id"
    t.integer  "previous_station_train_time_id"
    t.integer  "following_station_train_time_id"
    t.integer  "following_train_timetable_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_timetable_arrival_infos", force: :cascade do |t|
    t.integer  "station_info_id"
    t.integer  "platform_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_timetable_infos", force: :cascade do |t|
    t.string   "id_urn",                               limit: 255
    t.string   "same_as",                              limit: 255
    t.datetime "dc_date"
    t.string   "train_number",                         limit: 255
    t.integer  "railway_line_info_id"
    t.integer  "operator_info_id"
    t.integer  "train_type_info_id"
    t.integer  "train_name_id"
    t.integer  "railway_direction_id"
    t.integer  "operator_as_train_owner_id"
    t.integer  "operation_day_id"
    t.integer  "starting_station_info_id"
    t.integer  "terminal_station_info_id"
    t.integer  "car_composition"
    t.integer  "arrival_info_id"
    t.integer  "train_type_in_other_operator_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_timetable_train_names", force: :cascade do |t|
    t.integer  "train_timetable_info_id"
    t.integer  "train_name_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "train_timetable_train_type_in_other_operator_infos", force: :cascade do |t|
    t.integer  "from_station_info_id"
    t.integer  "railway_line_info_id"
    t.integer  "train_type_info_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_type_color_infos", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "color_info_id"
    t.integer  "bgcolor_info_id"
  end

  create_table "train_type_in_apis", force: :cascade do |t|
    t.string   "same_as",       limit: 255
    t.string   "name_ja",       limit: 255
    t.string   "name_ja_short", limit: 255
    t.string   "name_en",       limit: 255
    t.string   "name_en_short", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_type_infos", force: :cascade do |t|
    t.integer  "in_api_id"
    t.string   "note",                 limit: 255
    t.string   "same_as",              limit: 255
    t.integer  "railway_line_info_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "color_info_id"
  end

  create_table "train_type_note_additional_infos", force: :cascade do |t|
    t.integer  "info_id"
    t.integer  "additional_text_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "index"
  end

  create_table "train_type_note_additional_texts", force: :cascade do |t|
    t.string   "text_ja"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "train_type_note_infos", force: :cascade do |t|
    t.integer  "text_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "info_id"
  end

  create_table "train_type_note_texts", force: :cascade do |t|
    t.string   "text_ja"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "train_type_remarkable_stop_infos", force: :cascade do |t|
    t.integer  "train_type_info_id"
    t.integer  "remarkable_stop_info_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "train_type_specific_operation_days", force: :cascade do |t|
    t.integer  "train_type_info_id"
    t.integer  "specific_operation_day_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "train_type_stopping_patterns", force: :cascade do |t|
    t.integer  "train_type_info_id"
    t.integer  "railway_line_info_id"
    t.integer  "stopping_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_type_through_operation_infos", force: :cascade do |t|
    t.integer  "info_id"
    t.integer  "railway_line_info_id"
    t.integer  "to_station_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "twitter_accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "widget_id"
    t.integer  "operator_info_or_railway_line_info_id"
    t.string   "operator_info_or_railway_line_info_type"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

end
