class CreateTrainTimetableArrivalInfos < ActiveRecord::Migration
  def change
    create_table :train_timetable_arrival_infos do |t|
      t.integer :station_id
      t.integer :platform_number

      t.timestamps
    end
  end
end
