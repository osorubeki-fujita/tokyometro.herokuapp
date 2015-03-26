class RenameStationAlias < ActiveRecord::Migration
  def change
    rename_table :station_aliases , :station_name_aliases
    rename_column :stations , :station_alias , :station_name_alias
  end
end
