class AddIndexToRailwayLineInfoCode < ActiveRecord::Migration
  def change
    add_column :railway_line_info_codes, :index, :integer
    rename_column :railway_line_infos , :name_codes , :codes
  end
end
