class RenameInfosRelatedToTrainTimetableArrivalInfo < ActiveRecord::Migration
  def change
    rename_table :timetable_arrival_indos , :train_timetable_arrival_infos
    rename_column :train_timetables , :timetable_arrival_info_id , :train_timetable_arrival_info_id
  end
end
