class CreateTrainRelations < ActiveRecord::Migration
  def change
    create_table :train_relations do |t|
      t.integer :previous_train_timetable_id
      t.integer :previous_station_train_time_id
      t.integer :following_station_train_time_id
      t.integer :following_train_timetable_id

      t.timestamps
    end
  end
end
