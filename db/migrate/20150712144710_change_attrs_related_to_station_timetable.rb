class ChangeAttrsRelatedToStationTimetable < ActiveRecord::Migration
  def change
    rename_column :station_timetable_fundamental_infos , :station_timetable_id , :info_id
    rename_column :station_train_times , :station_timetable_id , :station_timetable_info_id
    rename_table :station_timetables , :station_timetable_infos
  end
end
