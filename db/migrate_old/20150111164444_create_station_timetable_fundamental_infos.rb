class CreateStationTimetableFundamentalInfos < ActiveRecord::Migration
  def change
    create_table :station_timetable_fundamental_infos do |t|
      t.integer :station_timetable_id
      t.integer :station_id
      t.integer :railway_id
      t.integer :railway_direction_id

      t.timestamps
    end
  end
end
