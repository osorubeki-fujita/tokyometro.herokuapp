class RenameRailwayIdToRailwayLineIdInStationTimetableFundamentalInfo < ActiveRecord::Migration
  def change
    rename_column :station_timetable_fundamental_infos , :railway_id , :railway_line_id
  end
end