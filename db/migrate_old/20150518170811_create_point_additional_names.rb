class CreatePointAdditionalNames < ActiveRecord::Migration
  def change
    create_table :point_additional_names do |t|
      t.string :ja
      t.string :en

      t.timestamps null: false
    end
  end
end
