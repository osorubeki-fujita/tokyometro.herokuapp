class CreateTrainBaseNames < ActiveRecord::Migration
  def change
    create_table :train_base_names do |t|
      t.string :name_ja
      t.string :name_hira
      t.string :name_en

      t.timestamps null: false
    end
  end
end
