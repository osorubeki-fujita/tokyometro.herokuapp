class CreateRailwayLineInfoCodes < ActiveRecord::Migration
  def change
    create_table :railway_line_info_codes do |t|
      t.integer :info_id
      t.integer :code_id
      t.integer :from_station_id
      t.integer :to_station_id

      t.timestamps null: false
    end
  end
end
