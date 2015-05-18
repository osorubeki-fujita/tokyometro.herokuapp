class RemoveColumnsFromPointInfo < ActiveRecord::Migration
  def change
    remove_column :point_infos , :code
    remove_column :point_infos , :additional_name_id
  end
end
