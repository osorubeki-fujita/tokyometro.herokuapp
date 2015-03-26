class RenameStation < ActiveRecord::Migration
  def change
    rename_table :stations , :station_infos
  end
end
