class AddHiddenOnRailwayLinePageToConnectingRailwayLine < ActiveRecord::Migration
  def change
    add_column :connecting_railway_lines, :hidden_on_railway_line_page, :boolean
  end
end
