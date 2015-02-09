class RemoveColumnsFromStationTrainTime < ActiveRecord::Migration
  def change
    remove_column :station_train_times , :arrival_info_of_last_station_in_tokyo_metro
    remove_column :station_train_times , :last_station_in_tokyo_metro_id
  end
end
