class RenameColumnsOfRealTimeInfos < ActiveRecord::Migration
  def change
    rename_column :train_location_infos , :valid , :valid_until
    rename_column :train_operation_infos , :valid , :valid_until
  end
end
