class AddTrainBaseNameIdToTrainName < ActiveRecord::Migration
  def change
    add_column :train_names, :train_basename_id, :integer
    add_column :train_names, :index, :integer
  end
end
