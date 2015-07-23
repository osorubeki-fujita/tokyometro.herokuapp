class RemoveColumnsOfRailwayLineInfo < ActiveRecord::Migration
  def change
    remove_column :railway_line_infos , :name_ja_normal
    remove_column :railway_line_infos , :name_ja_with_operator_name
    remove_column :railway_line_infos , :name_ja_with_operator_name_precise
    remove_column :railway_line_infos , :name_en_normal
    remove_column :railway_line_infos , :name_en_with_operator_name
    remove_column :railway_line_infos , :name_en_with_operator_name_precise
  end
end
