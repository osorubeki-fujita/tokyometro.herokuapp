class RenameColumnInConnectingRailwayLineNote < ActiveRecord::Migration
  def change
    rename_column :connecting_railway_line_notes , :note , :ja
  end
end
