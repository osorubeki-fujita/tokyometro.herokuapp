class RenameColumnsAndTablesRelatedToCode < ActiveRecord::Migration
  def change
    rename_table :operator_codes , :operator_code_infos
    rename_table :railway_line_codes , :railway_line_code_infos
    rename_table :railway_line_info_codes , :railway_line_info_code_infos
    rename_column :railway_line_info_code_infos , :code_id , :code_info_id
  end
end
