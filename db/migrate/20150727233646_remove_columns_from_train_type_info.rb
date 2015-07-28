class RemoveColumnsFromTrainTypeInfo < ActiveRecord::Migration
  def change
    remove_column :train_type_infos , :color
    remove_column :train_type_infos , :bgcolor
  end
end
