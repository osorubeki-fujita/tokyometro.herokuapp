class RenameTableTrainTypeThroughOperation < ActiveRecord::Migration
  def change
    rename_table :train_type_through_operations , :train_type_through_operation_infos
  end
end
