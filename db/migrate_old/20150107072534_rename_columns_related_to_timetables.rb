class RenameColumnsRelatedToTimetables < ActiveRecord::Migration
  def change
    rename_table :timetable_starting_station_infos , :station_timetable_starting_station_infos
    rename_table :timetable_connection_infos , :train_timetable_connection_infos

    rename_column :station_train_times , :timetable_starting_station_info_id , :station_timetable_starting_station_info_id
    rename_column :train_timetables , :timetable_connection_info_id , :train_timetable_connection_info_id
  end
end
