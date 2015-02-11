class AddIndexInTrainTimetableToStationTrainTime < ActiveRecord::Migration
  def change
    add_column :station_train_times, :index_in_train_timetable, :integer
  end
end
