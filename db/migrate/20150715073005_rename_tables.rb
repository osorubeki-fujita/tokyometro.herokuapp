class RenameTables < ActiveRecord::Migration
  def change
    rename_table :travel_time_infos , :railway_line_travel_time_infos
    rename_table :women_only_car_infos , :railway_line_women_only_car_infos
  end
end
