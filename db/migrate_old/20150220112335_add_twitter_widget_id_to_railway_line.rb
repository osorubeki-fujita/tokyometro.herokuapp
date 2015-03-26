class AddTwitterWidgetIdToRailwayLine < ActiveRecord::Migration
  def change
    add_column :railway_lines, :twitter_widget_id, :integer
  end
end