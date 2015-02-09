class RenameColumnOfTrainTimetable < ActiveRecord::Migration
  def change
    rename_column :train_timetables , :timetable_arrival_info_id , :train_timetable_arrival_info_id
  end
end
