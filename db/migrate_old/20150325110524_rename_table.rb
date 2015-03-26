class RenameTable < ActiveRecord::Migration
  def change
    rename_table :station_facility_platform_info_barrier_free_facilities , :station_facility_platform_info_barrier_free_facility_infos
  end
end
