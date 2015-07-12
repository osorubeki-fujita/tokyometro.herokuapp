class RenameAttrsOfStationStoppingPattern < ActiveRecord::Migration
  def change
    rename_column :station_stopping_patterns , :station_stopping_pattern_note_id , :note_id
    rename_table :station_stopping_patterns , :station_stopping_pattern_infos
  end
end
