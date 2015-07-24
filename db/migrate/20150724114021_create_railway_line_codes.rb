class CreateRailwayLineCodes < ActiveRecord::Migration
  def change
    create_table :railway_line_codes do |t|
      t.string :code
      t.string :hex_color

      t.timestamps null: false
    end
  end
end
