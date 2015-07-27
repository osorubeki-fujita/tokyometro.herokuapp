class RenameColumnInOperatorAsTrainOwner < ActiveRecord::Migration
  def change
    rename_column :operator_as_train_owners , :operator_info_id , :info_id
  end
end
