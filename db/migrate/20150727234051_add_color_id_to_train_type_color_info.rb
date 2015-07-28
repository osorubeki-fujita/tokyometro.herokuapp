class AddColorIdToTrainTypeColorInfo < ActiveRecord::Migration
  def change
    add_column :train_type_color_infos, :color_info_id, :integer
  end
end
