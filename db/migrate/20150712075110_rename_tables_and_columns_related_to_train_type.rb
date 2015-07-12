class RenameTablesAndColumnsRelatedToTrainType < ActiveRecord::Migration
  def change
    rename_column :station_train_times , :train_type_in_this_station_id , :train_type_info_in_this_station_id
    rename_column :travel_time_infos , :train_type_id , :train_type_info_id
    rename_column :train_timetable_train_type_in_other_operators , :train_type_id , :train_type_info_id

    rename_table :train_timetable_train_type_in_other_operators , :train_timetable_train_type_info_in_other_operators

    rename_column :train_timetables , :train_type_id , :train_type_info_id
    rename_column :train_timetables , :train_timetable_train_type_in_other_operator_id , :train_timetable_train_type_info_in_other_operator_id
    rename_column :train_type_stopping_patterns , :train_type_id , :train_type_info_id

    rename_table :train_types , :train_type_infos
  end
end
