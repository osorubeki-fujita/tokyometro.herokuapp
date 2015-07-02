class AddPointCodeIdToPointInfo < ActiveRecord::Migration
  def change
    add_column :point_infos, :code_id, :integer
  end
end
