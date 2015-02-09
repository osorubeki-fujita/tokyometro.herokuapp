class AddStationTimetableConnectionInfoIdToStationTrainTime < ActiveRecord::Migration
  def change
    add_column :station_train_times, :station_timetable_connection_info_id, :integer
  end
end