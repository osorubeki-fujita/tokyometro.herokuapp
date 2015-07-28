class RemoveColumnsFromTrainTypeColorInfo < ActiveRecord::Migration
  def change
    remove_column :train_type_color_infos , :color
    remove_column :train_type_color_infos , :bgcolor
  end
end
