class RenameColumnInRailwayLineInfo < ActiveRecord::Migration
  def change
    rename_column :railway_line_infos , :index , :index_in_operator
  end
end
