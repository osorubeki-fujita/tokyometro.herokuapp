class CreateStationStationTimetables < ActiveRecord::Migration
  def change
    create_table :station_station_timetables do |t|
      t.integer :station_id
      t.integer :station_timetable_id

      t.timestamps
    end
  end
end
