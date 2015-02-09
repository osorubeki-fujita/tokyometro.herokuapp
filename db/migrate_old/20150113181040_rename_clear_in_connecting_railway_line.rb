class RenameClearInConnectingRailwayLine < ActiveRecord::Migration
  def change
    rename_column :connecting_railway_lines , :clear , :cleared
  end
end
