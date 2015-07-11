class RemoveCssClassNameFromOperator < ActiveRecord::Migration
  def change
    remove_column :operators , :css_class
  end
end
