class AddRailwayDirectionIdToStationStationTimetable < ActiveRecord::Migration
  def change
    add_column :station_station_timetables, :railway_direction_id, :integer
  end
end
