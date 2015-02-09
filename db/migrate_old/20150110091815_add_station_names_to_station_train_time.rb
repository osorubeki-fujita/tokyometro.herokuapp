class AddStationNamesToStationTrainTime < ActiveRecord::Migration
  def change
    add_column :station_train_times, :departure_station_id, :integer
    add_column :station_train_times, :arrival_station_id, :integer
  end
end
