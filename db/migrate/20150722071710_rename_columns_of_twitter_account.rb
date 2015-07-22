class RenameColumnsOfTwitterAccount < ActiveRecord::Migration
  def change
    rename_column :twitter_accounts , :operator_or_railway_line_info_id , :operator_info_or_railway_line_info_id
    rename_column :twitter_accounts , :operator_or_railway_line_info_type , :operator_info_or_railway_line_info_type
  end
end
