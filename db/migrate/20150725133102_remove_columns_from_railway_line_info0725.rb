class RemoveColumnsFromRailwayLineInfo0725 < ActiveRecord::Migration
  def change
    remove_column :railway_line_infos , :codes
    remove_column :railway_line_infos , :color
  end
end
