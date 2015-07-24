class RenameColumnInRailwayLineCode < ActiveRecord::Migration
  def change
    rename_column :railway_line_codes , :hex_color , :color
  end
end
