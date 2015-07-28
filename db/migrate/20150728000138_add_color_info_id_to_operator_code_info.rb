class AddColorInfoIdToOperatorCodeInfo < ActiveRecord::Migration
  def change
    add_column :operator_code_infos, :color_info_id, :integer
  end
end
