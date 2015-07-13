class RenameTableNormalFareGroup < ActiveRecord::Migration
  def change
    rename_table :normal_fare_groups , :fare_normal_groups
    rename_table :fares , :fare_infos
    rename_column :fare_infos , :normal_fare_group_id , :normal_group_id
  end
end
