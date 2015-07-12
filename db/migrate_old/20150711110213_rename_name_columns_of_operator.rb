class RenameNameColumnsOfOperator < ActiveRecord::Migration
  def change
    rename_column :operators , :name_ja_to_haml , :name_ja_very_precise
    rename_column :operators , :name_en_to_haml , :name_en_very_precise
  end
end
