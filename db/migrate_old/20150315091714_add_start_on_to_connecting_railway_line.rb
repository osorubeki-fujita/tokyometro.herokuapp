class AddStartOnToConnectingRailwayLine < ActiveRecord::Migration
  def change
    add_column :connecting_railway_lines, :start_on, :datetime
  end
end
