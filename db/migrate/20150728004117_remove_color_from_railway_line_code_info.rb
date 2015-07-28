class RemoveColorFromRailwayLineCodeInfo < ActiveRecord::Migration
  def change
    remove_column :railway_line_code_infos , :color
  end
end
