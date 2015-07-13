class RenameColumnOfTrainLocationInfo < ActiveRecord::Migration
  def change
    rename_column :train_location_infos , :train_time_in_api_id , :train_time_info_id
  end
end
