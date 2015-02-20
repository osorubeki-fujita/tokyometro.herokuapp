class AddStartOnToRailwayLine < ActiveRecord::Migration
  def change
    add_column :railway_lines, :start_on, :datetime
  end
end
