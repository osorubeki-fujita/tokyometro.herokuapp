class AddRailwayIdToStationStationTimetable < ActiveRecord::Migration
  def change
    add_column :station_station_timetables, :railway_id, :integer
  end
end
