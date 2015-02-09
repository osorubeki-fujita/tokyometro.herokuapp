class AddPlatformNumberToStationTrainTime < ActiveRecord::Migration
  def change
    rename_column :station_train_times, :depart_from , :platform_number
  end
end
