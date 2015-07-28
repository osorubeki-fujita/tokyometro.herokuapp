class CreateDesignColorInfos < ActiveRecord::Migration
  def change
    create_table :design_color_infos do |t|
      t.string :hex_color
      t.string :name_ja

      t.timestamps null: false
    end
  end
end
