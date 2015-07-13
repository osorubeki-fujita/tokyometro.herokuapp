class RenameColumnsOfAirConditionerInfo < ActiveRecord::Migration
  def change
    rename_column :air_conditioner_infos , :train_location_data_id , :train_location_info_id
    remove_column :air_conditioner_infos , :train_location_data_type
  end
end
