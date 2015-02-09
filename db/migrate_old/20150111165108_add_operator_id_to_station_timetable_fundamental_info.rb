class AddOperatorIdToStationTimetableFundamentalInfo < ActiveRecord::Migration
  def change
    add_column :station_timetable_fundamental_infos, :operator_id, :integer
  end
end
