class AddAdditionalNameIdToPointInfo < ActiveRecord::Migration
  def change
    add_column :point_infos, :additional_name_id, :integer
  end
end
