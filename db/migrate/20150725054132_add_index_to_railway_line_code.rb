class AddIndexToRailwayLineCode < ActiveRecord::Migration
  def change
    add_column :railway_line_codes, :index, :integer
  end
end
