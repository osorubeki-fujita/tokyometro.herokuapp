class AddApiInfoToRailwayLineAdditionalInfo < ActiveRecord::Migration
  def change
    add_column :railway_line_additional_infos, :api_info, :boolean
  end
end
