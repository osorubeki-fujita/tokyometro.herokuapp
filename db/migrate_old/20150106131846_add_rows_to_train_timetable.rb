class AddRowsToTrainTimetable < ActiveRecord::Migration
  def change
    add_column :train_timetables, :previous_train_id, :integer
    add_column :train_timetables, :following_train_id, :integer
  end
end
