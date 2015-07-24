class RemoveColumnsFromOperatorInfo < ActiveRecord::Migration
  def change
    remove_column :operator_infos , :railway_line_code_shape
    remove_column :operator_infos , :station_code_shape

    remove_column :operator_infos , :numbering
    remove_column :operator_infos , :operator_code
    remove_column :operator_infos , :color
  end
end
