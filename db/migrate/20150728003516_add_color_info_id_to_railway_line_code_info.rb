class AddColorInfoIdToRailwayLineCodeInfo < ActiveRecord::Migration
  def change
    add_column :railway_line_code_infos, :color_info_id, :integer
  end
end
