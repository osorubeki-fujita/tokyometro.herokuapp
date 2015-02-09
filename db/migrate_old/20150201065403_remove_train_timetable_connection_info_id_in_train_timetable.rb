class RemoveTrainTimetableConnectionInfoIdInTrainTimetable < ActiveRecord::Migration
  def change
    remove_column :train_timetables , :train_timetable_connection_info_id
  end
end