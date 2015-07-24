class RenameTableTrainBasename < ActiveRecord::Migration
  def change
    rename_table :train_base_names , :train_basenames
  end
end
