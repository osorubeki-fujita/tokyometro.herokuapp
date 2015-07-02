class RenameTableConnectingRailwayLine < ActiveRecord::Migration
  def change
    rename_table :connecting_railway_lines , :connecting_railway_line_infos
    rename_column :connecting_railway_line_infos , :connecting_railway_line_note_id , :note_id
  end
end
