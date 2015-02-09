class DestroyTimetableArrivalInfo < ActiveRecord::Migration
  def change
    drop_table :timetable_arrival_infos
  end
end
