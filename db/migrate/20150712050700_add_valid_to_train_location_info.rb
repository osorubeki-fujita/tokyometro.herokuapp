class AddValidToTrainLocationInfo < ActiveRecord::Migration
  def change
    add_column :train_location_infos, :valid, :boolean
  end
end
