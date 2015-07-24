class CreateOperatorCodes < ActiveRecord::Migration
  def change
    create_table :operator_codes do |t|
      t.string :code
      t.string :color
      t.string :railway_line_code_shape
      t.string :railway_line_code_stroke_width_setting
      t.string :railway_line_code_text_weight
      t.string :railway_line_code_text_size_setting
      t.string :station_code_shape
      t.string :station_code_stroke_width_setting
      t.string :station_code_text_weight
      t.string :station_code_text_size_setting

      t.timestamps null: false
    end
  end
end
