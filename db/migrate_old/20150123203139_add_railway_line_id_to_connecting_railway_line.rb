class AddRailwayLineIdToConnectingRailwayLine < ActiveRecord::Migration
  def change
    add_column :connecting_railway_lines , :railway_line_id , :integer
  end
end
