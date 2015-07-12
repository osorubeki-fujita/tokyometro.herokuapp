class RenameColumnsOfOperator < ActiveRecord::Migration
  def change
    rename_column :operators , :name_ja_display , :name_ja_short
    rename_column :operators , :name_en_display , :name_en_short
  end
end
