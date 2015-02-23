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

ActiveRecord::Schema.define(version: 20150315091756) do

  create_table "air_conditioner_answers", force: true do |t|
    t.string   "name_ja"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "air_conditioners", force: true do |t|
    t.integer  "railway_line_id"
    t.integer  "train_id"
    t.integer  "car_number"
    t.datetime "post_time"
    t.integer  "air_conditioner_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facilities", force: true do |t|
    t.string   "id_urn"
    t.string   "same_as"
    t.integer  "station_facility_id"
    t.integer  "barrier_free_facility_type_id"
    t.integer  "barrier_free_facility_located_area_id"
    t.string   "remark"
    t.boolean  "is_available_to_wheel_chair"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_escalator_direction_patterns", force: true do |t|
    t.boolean  "up"
    t.boolean  "down"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_escalator_directions", force: true do |t|
    t.integer  "barrier_free_facility_service_detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "barrier_free_facility_escalator_direction_pattern_id"
  end

  create_table "barrier_free_facility_located_areas", force: true do |t|
    t.string   "name_ja"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_place_names", force: true do |t|
    t.string   "name_ja"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_root_infos", force: true do |t|
    t.integer  "barrier_free_facility_id"
    t.integer  "barrier_free_facility_place_name_id"
    t.integer  "index_in_root"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_service_detail_patterns", force: true do |t|
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

  create_table "barrier_free_facility_service_details", force: true do |t|
    t.integer  "barrier_free_facility_id"
    t.integer  "barrier_free_facility_service_detail_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_toilet_assistant_patterns", force: true do |t|
    t.boolean  "wheel_chair_accessible"
    t.boolean  "baby_chair"
    t.boolean  "baby_changing_table"
    t.boolean  "ostomate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_toilet_assistants", force: true do |t|
    t.integer  "barrier_free_facility_id"
    t.integer  "barrier_free_facility_toilet_assistant_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barrier_free_facility_types", force: true do |t|
    t.string   "type"
    t.string   "name_ja"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connecting_railway_line_notes", force: true do |t|
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connecting_railway_lines", force: true do |t|
    t.integer  "station_id"
    t.integer  "index_in_station"
    t.integer  "railway_line_id"
    t.integer  "connecting_station_id"
    t.boolean  "connecting_to_another_station"
    t.boolean  "cleared"
    t.boolean  "not_recommended"
    t.integer  "connecting_railway_line_note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_on"
  end

  create_table "fares", force: true do |t|
    t.string   "same_as"
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.integer  "operator_id"
    t.integer  "normal_fare_group_id"
    t.string   "id_urn"
    t.datetime "dc_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "normal_fare_groups", force: true do |t|
    t.integer  "ticket_fare"
    t.integer  "child_ticket_fare"
    t.integer  "ic_card_fare"
    t.integer  "child_ic_card_fare"
    t.integer  "operator_id"
    t.date     "date_of_revision"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operation_days", force: true do |t|
    t.string   "same_as"
    t.string   "name_ja"
    t.string   "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", force: true do |t|
    t.string   "name_ja"
    t.string   "name_hira"
    t.string   "name_en"
    t.float    "index"
    t.string   "railway_line_code_shape"
    t.string   "same_as"
    t.string   "name_ja_display"
    t.string   "name_en_display"
    t.boolean  "numbering"
    t.string   "station_code_shape"
    t.string   "operator_code"
    t.string   "color"
    t.string   "name_ja_normal_precise"
    t.string   "name_ja_normal"
    t.string   "name_ja_for_transfer_info"
    t.string   "name_ja_to_haml"
    t.string   "name_en_normal_precise"
    t.string   "name_en_normal"
    t.string   "name_en_for_transfer_info"
    t.string   "name_en_to_haml"
    t.string   "css_class_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "twitter_widget_id"
    t.string   "twitter_account"
  end

  create_table "passenger_surveys", force: true do |t|
    t.integer  "survey_year"
    t.integer  "station_id"
    t.integer  "operator_id"
    t.integer  "passenger_journeys"
    t.string   "same_as"
    t.string   "id_urn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "point_categories", force: true do |t|
    t.string   "name_ja"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", force: true do |t|
    t.string   "id_urn"
    t.integer  "station_facility_id"
    t.integer  "point_category_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geo_json"
    t.integer  "floor"
    t.string   "code"
    t.string   "additional_info"
    t.boolean  "elevator"
    t.boolean  "closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "railway_directions", force: true do |t|
    t.string   "same_as"
    t.string   "in_api_same_as"
    t.integer  "railway_line_id"
    t.integer  "station_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "railway_direction_code"
  end

  create_table "railway_lines", force: true do |t|
    t.string   "name_ja"
    t.string   "name_ja_normal"
    t.string   "name_ja_with_operator_name_precise"
    t.string   "name_ja_with_operator_name"
    t.string   "name_hira"
    t.string   "name_en"
    t.string   "name_en_normal"
    t.string   "name_en_with_operator_name_precise"
    t.string   "name_en_with_operator_name"
    t.integer  "operator_id"
    t.string   "same_as"
    t.float    "index"
    t.string   "color"
    t.string   "css_class_name"
    t.string   "name_code"
    t.string   "id_urn"
    t.time     "dc_date"
    t.string   "geo_json"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_on"
    t.integer  "twitter_widget_id"
    t.string   "twitter_account"
    t.boolean  "is_branch_railway_line"
    t.integer  "main_railway_line_id"
    t.boolean  "has_branch_railway_line"
    t.integer  "branch_railway_line_id"
  end

  create_table "rss_categories", force: true do |t|
    t.string   "title"
    t.string   "feed_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsses", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "feed_url"
    t.string   "etag"
    t.datetime "last_modified"
    t.integer  "rss_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_aliases", force: true do |t|
    t.integer  "station_id"
    t.string   "same_as"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facilities", force: true do |t|
    t.string   "same_as"
    t.string   "id_urn"
    t.datetime "dc_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_aliases", force: true do |t|
    t.integer  "station_facility_id"
    t.string   "same_as"
    t.integer  "index_of_alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_info_barrier_free_facilities", force: true do |t|
    t.integer  "station_facility_platform_info_id"
    t.integer  "barrier_free_facility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_info_surrounding_areas", force: true do |t|
    t.integer  "station_facility_platform_info_id"
    t.integer  "surrounding_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_info_transfer_infos", force: true do |t|
    t.integer  "station_facility_platform_info_id"
    t.integer  "railway_line_id"
    t.integer  "railway_direction_id"
    t.integer  "necessary_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_facility_platform_infos", force: true do |t|
    t.integer  "station_facility_id"
    t.integer  "car_composition"
    t.integer  "car_number"
    t.integer  "railway_line_id"
    t.integer  "railway_direction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_passenger_surveys", force: true do |t|
    t.integer  "station_id"
    t.integer  "passenger_survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_points", force: true do |t|
    t.integer  "station_id"
    t.integer  "point_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_stopping_pattern_notes", force: true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_stopping_patterns", force: true do |t|
    t.integer  "station_id"
    t.integer  "stopping_pattern_id"
    t.boolean  "partial"
    t.boolean  "for_driver"
    t.integer  "station_stopping_pattern_note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetable_connection_infos", force: true do |t|
    t.integer  "station_id"
    t.string   "note"
    t.boolean  "connection"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetable_fundamental_infos", force: true do |t|
    t.integer  "station_timetable_id", null: false
    t.integer  "station_id",           null: false
    t.integer  "operator_id",          null: false
    t.integer  "railway_line_id",      null: false
    t.integer  "railway_direction_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetable_starting_station_infos", force: true do |t|
    t.integer  "station_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_timetables", force: true do |t|
    t.string   "id_urn",     null: false
    t.string   "same_as",    null: false
    t.datetime "dc_date",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "station_train_times", force: true do |t|
    t.integer  "station_timetable_id"
    t.integer  "train_timetable_id"
    t.integer  "departure_station_id"
    t.integer  "departure_time_hour"
    t.integer  "departure_time_min"
    t.integer  "arrival_station_id"
    t.integer  "arrival_time_hour"
    t.integer  "arrival_time_min"
    t.boolean  "is_last"
    t.boolean  "is_origin"
    t.integer  "platform_number"
    t.integer  "station_timetable_starting_station_info_id"
    t.integer  "train_type_in_this_station_id"
    t.boolean  "stop_for_drivers"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "station_timetable_connection_info_id"
    t.integer  "index_in_train_timetable"
  end

  create_table "stations", force: true do |t|
    t.integer  "operator_id"
    t.string   "same_as"
    t.integer  "railway_line_id"
    t.integer  "index_in_railway_line"
    t.string   "station_code"
    t.integer  "station_facility_id"
    t.string   "name_ja"
    t.string   "name_hira"
    t.string   "name_en"
    t.string   "name_in_system"
    t.string   "id_urn"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "station_alias"
    t.string   "station_facility_custom"
    t.string   "station_facility_custom_alias"
    t.datetime "dc_date"
    t.string   "geo_json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stopping_patterns", force: true do |t|
    t.string   "same_as"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surrounding_areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_information_olds", force: true do |t|
    t.string   "id_urn"
    t.datetime "dc_date"
    t.datetime "valid"
    t.integer  "operator_id"
    t.datetime "time_of_origin"
    t.integer  "railway_line_id"
    t.integer  "train_information_status_id"
    t.string   "train_information_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_information_statuses", force: true do |t|
    t.string   "name_ja"
    t.string   "name_en"
    t.string   "in_api"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_informations", force: true do |t|
    t.string   "id_urn"
    t.datetime "dc_date"
    t.datetime "valid"
    t.integer  "operator_id"
    t.datetime "time_of_origin"
    t.integer  "railway_line_id"
    t.integer  "train_information_status_id"
    t.string   "train_information_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_location_olds", force: true do |t|
    t.string   "id_urn"
    t.string   "same_as"
    t.datetime "dc_date"
    t.datetime "valid"
    t.integer  "frequency"
    t.string   "train_number"
    t.integer  "train_time_in_api_id"
    t.integer  "railway_line_id"
    t.integer  "train_owner_id"
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.integer  "railway_direction_id"
    t.integer  "delay"
    t.integer  "now_from"
    t.integer  "now_to"
    t.integer  "now_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_locations", force: true do |t|
    t.string   "id_urn"
    t.string   "same_as"
    t.datetime "dc_date"
    t.datetime "valid"
    t.integer  "frequency"
    t.string   "train_number"
    t.integer  "train_time_in_api_id"
    t.integer  "railway_line_id"
    t.integer  "train_owner_id"
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.integer  "railway_direction_id"
    t.integer  "delay"
    t.integer  "now_from"
    t.integer  "now_to"
    t.integer  "now_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_owners", force: true do |t|
    t.integer  "operator_id"
    t.string   "same_as"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_relations", force: true do |t|
    t.integer  "previous_train_timetable_id"
    t.integer  "previous_station_train_time_id"
    t.integer  "following_station_train_time_id"
    t.integer  "following_train_timetable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_timetable_arrival_infos", force: true do |t|
    t.integer  "station_id"
    t.integer  "platform_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_timetable_train_type_in_other_operators", force: true do |t|
    t.integer  "from_station_id"
    t.integer  "railway_line_id"
    t.integer  "train_type_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_timetables", force: true do |t|
    t.string   "id_urn"
    t.string   "same_as"
    t.datetime "dc_date"
    t.string   "train_number"
    t.integer  "railway_line_id"
    t.integer  "operator_id"
    t.integer  "train_type_id"
    t.integer  "train_name_id"
    t.integer  "railway_direction_id"
    t.integer  "train_owner_id"
    t.integer  "operation_day_id"
    t.integer  "starting_station_id"
    t.integer  "terminal_station_id"
    t.integer  "car_composition"
    t.integer  "train_timetable_arrival_info_id"
    t.integer  "train_timetable_train_type_in_other_operator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_type_in_apis", force: true do |t|
    t.string   "same_as"
    t.string   "name_ja"
    t.string   "name_ja_display"
    t.string   "name_ja_normal"
    t.string   "name_en"
    t.string   "name_en_display"
    t.string   "name_en_normal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_type_stopping_patterns", force: true do |t|
    t.integer  "train_type_id"
    t.integer  "railway_line_id"
    t.integer  "stopping_pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "train_types", force: true do |t|
    t.integer  "train_type_in_api_id"
    t.string   "note"
    t.string   "same_as"
    t.string   "css_class_name"
    t.string   "color"
    t.string   "bgcolor"
    t.integer  "railway_line_id"
    t.string   "css_class_name_in_document"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_time_infos", force: true do |t|
    t.integer  "railway_line_id"
    t.integer  "from_station_id"
    t.integer  "to_station_id"
    t.integer  "train_type_id"
    t.integer  "necessary_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "women_only_car_infos", force: true do |t|
    t.integer  "railway_line_id",           null: false
    t.integer  "from_station_id",           null: false
    t.integer  "to_station_id",             null: false
    t.integer  "operation_day_id",          null: false
    t.integer  "available_time_from_hour",  null: false
    t.integer  "available_time_from_min",   null: false
    t.integer  "available_time_until_hour", null: false
    t.integer  "available_time_until_min",  null: false
    t.integer  "car_composition",           null: false
    t.integer  "car_number",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
