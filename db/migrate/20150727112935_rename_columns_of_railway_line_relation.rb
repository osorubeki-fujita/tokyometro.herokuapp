class RenameColumnsOfRailwayLineRelation < ActiveRecord::Migration
  def change
    rename_column :railway_line_relations , :main_id , :main_railway_line_info_id
    rename_column :railway_line_relations , :branch_id , :branch_railway_line_info_id
  end
end
