class RenameTableAndColumnsRelatedToTrainOwner < ActiveRecord::Migration
  def change
    rename_table :train_owners , :operator_as_train_owners
    rename_column :train_timetable_infos , :train_owner_id , :operator_as_train_owner_id
    rename_column :train_location_infos , :train_owner_id , :operator_as_train_owner_id
  end
end
