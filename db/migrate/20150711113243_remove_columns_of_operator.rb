class RemoveColumnsOfOperator < ActiveRecord::Migration
  def change
    remove_columns :operators , :name_ja_normal_precise
    remove_columns :operators , :name_ja_normal
    remove_columns :operators , :name_ja_for_transfer_info
    remove_columns :operators , :name_ja_very_precise
    remove_columns :operators , :name_en_normal_precise
    remove_columns :operators , :name_en_normal
    remove_columns :operators , :name_en_for_transfer_info
    remove_columns :operators , :name_en_very_precise
  end
end
