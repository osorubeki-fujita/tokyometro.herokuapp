class RenameTableAndColumnsRelatedToOperator < ActiveRecord::Migration
  def change
    rename_table :operators , :operator_infos
    rename_column :fare_infos , :operator_id , :operator_info_id
    rename_column :fare_normal_groups , :operator_id , :operator_info_id
    rename_column :railway_line_infos , :operator_id , :operator_info_id
    rename_column :station_infos , :operator_id , :operator_info_id
    rename_column :station_timetable_fundamental_infos , :operator_id , :operator_info_id
    rename_column :train_operation_infos , :operator_id , :operator_info_id
    rename_column :train_owners , :operator_id , :operator_info_id
    rename_column :train_timetable_infos , :operator_id , :operator_info_id
  end
end
