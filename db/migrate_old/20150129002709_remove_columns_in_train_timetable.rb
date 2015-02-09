class RemoveColumnsInTrainTimetable < ActiveRecord::Migration
  def change
    remove_column :train_timetables , :previous_train_id
    remove_column :train_timetables , :following_train_id
  end
end