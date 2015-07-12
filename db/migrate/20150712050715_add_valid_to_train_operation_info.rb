class AddValidToTrainOperationInfo < ActiveRecord::Migration
  def change
    add_column :train_operation_infos, :valid, :boolean
  end
end
