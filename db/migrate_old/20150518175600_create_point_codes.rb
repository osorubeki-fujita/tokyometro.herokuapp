class CreatePointCodes < ActiveRecord::Migration
  def change
    create_table :point_codes do |t|
      t.string :main
      t.integer :additional_name_id

      t.timestamps null: false
    end
  end
end
