class DropTrainTime < ActiveRecord::Migration
  def change
    drop_table :train_times
  end
end
