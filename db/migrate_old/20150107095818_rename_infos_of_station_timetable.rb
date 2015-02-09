class RenameInfosOfStationTimetable < ActiveRecord::Migration
  def change
    rename_column :station_train_times , :timetable_id , :station_timetable_id
    rename_column :train_times , :timetable_id , :station_timetable_id
    rename_table :timetables , :station_timetables
  end
end
