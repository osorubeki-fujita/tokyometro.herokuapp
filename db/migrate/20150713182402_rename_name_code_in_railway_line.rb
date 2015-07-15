class RenameNameCodeInRailwayLine < ActiveRecord::Migration
  def change
    rename_column :railway_lines , :name_code , :name_codes
  end
end
