class ChangeToConnectingRailwayLine < ActiveRecord::Migration
  def change
    remove_column :connecting_railway_lines , :railway_line_id
    remove_column :connecting_railway_lines , :another_station_id
    add_column :connecting_railway_lines , :connecting_to_another_station , :boolean
  end
end
