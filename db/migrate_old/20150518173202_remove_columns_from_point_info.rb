class RemoveColumnsFromPointInfo < ActiveRecord::Migration
  def change
    remove_column :point_infos , :additional_info_ja
    remove_column :point_infos , :additional_info_en
  end
end
