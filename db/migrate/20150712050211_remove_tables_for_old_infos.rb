class RemoveTablesForOldInfos < ActiveRecord::Migration
  def change
    drop_table :train_location_old_infos
    drop_table :train_operation_old_infos
  end
end
