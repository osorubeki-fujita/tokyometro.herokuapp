class RenameColumnOfTrainTypeInfo < ActiveRecord::Migration
  def change
    rename_column :train_type_infos , :train_type_in_api_id , :in_api_id
  end
end
