class RenameAndRemoveColumnsOfTrainTypeInApi < ActiveRecord::Migration
  def change
    rename_column :train_type_in_apis , :name_ja_display , :name_ja_short
    rename_column :train_type_in_apis , :name_en_display , :name_en_short

    remove_column :train_type_in_apis , :name_ja_normal
    remove_column :train_type_in_apis , :name_en_normal
  end
end
