class RenameLineCodeShapeToRailwayLineCodeShapeInOperators < ActiveRecord::Migration
  def change
    rename_column :operators , :line_code_shape , :railway_line_code_shape
  end
end
