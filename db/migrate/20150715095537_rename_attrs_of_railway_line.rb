class RenameAttrsOfRailwayLine < ActiveRecord::Migration
  def change
    rename_table :railway_lines , :railway_line_infos

    rename_column :railway_line_infos , :main_railway_line_id , :main_railway_line_info_id
    rename_column :railway_line_infos , :branch_railway_line_id , :branch_railway_line_info_id

    rename_column :twitter_accounts , :operator_or_railway_line_id , :operator_or_railway_line_info_id
    rename_column :twitter_accounts , :operator_or_railway_line_type , :operator_or_railway_line_info_type

    rename_column :air_conditioner_infos , :railway_line_id , :railway_line_info_id
    rename_column :connecting_railway_line_infos , :railway_line_id , :railway_line_info_id
    rename_column :railway_directions , :railway_line_id , :railway_line_info_id
    rename_column :railway_line_travel_time_infos , :railway_line_id , :railway_line_info_id
    rename_column :railway_line_women_only_car_infos , :railway_line_id , :railway_line_info_id

    rename_column :station_facility_platform_infos , :railway_line_id , :railway_line_info_id
    rename_column :station_facility_platform_transfer_infos , :railway_line_id , :railway_line_info_id
    rename_column :station_infos , :railway_line_id , :railway_line_info_id
    rename_column :station_timetable_fundamental_infos , :railway_line_id , :railway_line_info_id
    rename_column :train_location_infos , :railway_line_id , :railway_line_info_id
    rename_column :train_operation_infos , :railway_line_id , :railway_line_info_id

    rename_column :train_timetable_infos , :railway_line_id , :railway_line_info_id
    rename_column :train_timetable_train_type_in_other_operator_infos , :railway_line_id , :railway_line_info_id
    rename_column :train_type_infos , :railway_line_id , :railway_line_info_id
    rename_column :train_type_stopping_patterns , :railway_line_id , :railway_line_info_id
  end
end
