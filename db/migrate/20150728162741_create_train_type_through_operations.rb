class CreateTrainTypeThroughOperations < ActiveRecord::Migration
  def change
    create_table :train_type_through_operations do |t|
      t.integer :info_id
      t.integer :railway_line_info_id
      t.integer :to_station_id

      t.timestamps null: false
    end
  end
end
