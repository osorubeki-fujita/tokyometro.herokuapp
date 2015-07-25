class RemoveIndexFromRailwayLineCode < ActiveRecord::Migration
  def change
    remove_column :railway_line_codes , :index
  end
end
