class CreateRailwayLineAdditionalInfos < ActiveRecord::Migration
  def change
    create_table :railway_line_additional_infos do |t|
      t.integer :info_id
      t.string :id_urn
      t.datetime :dc_date
      t.string :geo_json

      t.timestamps null: false
    end
  end
end
