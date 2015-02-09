class AddConnectingStationIdToConnectingRailwayLine < ActiveRecord::Migration
  def change
    add_column :connecting_railway_lines, :connecting_station_id, :integer
  end
end
