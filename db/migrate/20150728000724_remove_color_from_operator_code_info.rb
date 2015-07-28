class RemoveColorFromOperatorCodeInfo < ActiveRecord::Migration
  def change
    remove_column :operator_code_infos , :color
  end
end
