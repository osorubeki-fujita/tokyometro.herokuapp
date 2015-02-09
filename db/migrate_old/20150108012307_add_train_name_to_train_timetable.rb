class AddTrainNameToTrainTimetable < ActiveRecord::Migration
  def change
    add_column :train_timetables, :train_name, :string
  end
end
