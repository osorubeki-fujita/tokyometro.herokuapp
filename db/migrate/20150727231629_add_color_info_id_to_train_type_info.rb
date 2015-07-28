class AddColorInfoIdToTrainTypeInfo < ActiveRecord::Migration
  def change
    add_column :train_type_infos, :color_info_id, :integer
  end
end
