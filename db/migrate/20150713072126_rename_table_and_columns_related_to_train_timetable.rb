class RenameTableAndColumnsRelatedToTrainTimetable < ActiveRecord::Migration
  def change
    rename_table :train_timetables , :train_timetable_infos
    rename_table :train_timetable_train_type_info_in_other_operators , :train_timetable_train_type_in_other_operator_infos

    rename_column :train_timetable_infos , :train_timetable_arrival_info_id , :arrival_info_id
    rename_column :train_timetable_infos , :train_timetable_train_type_info_in_other_operator_id , :train_type_in_other_operator_info_id

    rename_column :station_train_times , :train_timetable_id , :train_timetable_info_id
    rename_column :station_train_times , :index_in_train_timetable , :index_in_train_timetable_info
  end
end
