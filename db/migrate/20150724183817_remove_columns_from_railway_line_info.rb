class RemoveColumnsFromRailwayLineInfo < ActiveRecord::Migration
  def change
    remove_column :railway_line_infos , :id_urn
    remove_column :railway_line_infos , :dc_date
    remove_column :railway_line_infos , :geo_json
  end
end
