class CreateRailwayLineRelations < ActiveRecord::Migration
  def change
    create_table :railway_line_relations do |t|
      t.integer :main_id
      t.integer :branch_id

      t.timestamps null: false
    end
  end
end
