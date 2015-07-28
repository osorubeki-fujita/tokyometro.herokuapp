class AddBgColorIdToTrainTypeColorInfo < ActiveRecord::Migration
  def change
    add_column :train_type_color_infos, :bgcolor_info_id, :integer
  end
end
