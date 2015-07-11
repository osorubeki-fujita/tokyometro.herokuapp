class RemoveCssClassNameFromRailwayLine < ActiveRecord::Migration
  def change
    remove_column :railway_lines , :css_class
  end
end
