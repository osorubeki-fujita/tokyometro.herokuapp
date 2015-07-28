class CreateTrainTypeColorInfos < ActiveRecord::Migration
  def change
    create_table :train_type_color_infos do |t|
      t.string :color
      t.string :bgcolor

      t.timestamps null: false
    end
  end
end
