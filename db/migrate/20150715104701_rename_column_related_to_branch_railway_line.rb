class RenameColumnRelatedToBranchRailwayLine < ActiveRecord::Migration
  def change
    rename_column :railway_line_infos , :is_branch_railway_line , :is_branch_railway_line_info
    rename_column :railway_line_infos , :has_branch_railway_line , :has_branch_railway_line_info
  end
end
