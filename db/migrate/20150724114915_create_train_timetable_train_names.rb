class CreateTrainTimetableTrainNames < ActiveRecord::Migration
  def change
    create_table :train_timetable_train_names do |t|
      t.integer :train_timetable_info_id
      t.integer :train_name_id

      t.timestamps null: false
    end
  end
end
