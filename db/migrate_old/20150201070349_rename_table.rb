class RenameTable < ActiveRecord::Migration
  def change
    rename_table :train_timetable_connection_infos , :station_timetable_connection_infos
  end
end