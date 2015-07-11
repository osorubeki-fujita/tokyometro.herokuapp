class RemoveCssClassNameInDocument < ActiveRecord::Migration
  def change
    remove_column :train_types , :css_class_name_in_document
  end
end
