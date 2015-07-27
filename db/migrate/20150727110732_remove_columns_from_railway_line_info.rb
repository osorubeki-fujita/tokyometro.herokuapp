class RemoveColumnsFromRailwayLineInfo < ActiveRecord::Migration
  def change
    remove_column :railway_line_infos , :is_branch_railway_line_info
    remove_column :railway_line_infos , :main_railway_line_info_id
    remove_column :railway_line_infos , :has_branch_railway_line_info
    remove_column :railway_line_infos , :branch_railway_line_info_id
  end
end
