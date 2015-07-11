class RemoveCssClassNameFromTrainType < ActiveRecord::Migration
  def change
    remove_column :train_types , :css_class_name
  end
end
