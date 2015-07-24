class CreateTrainNames < ActiveRecord::Migration
  def change
    create_table :train_names do |t|
      t.string :same_as

      t.timestamps null: false
    end
  end
end
