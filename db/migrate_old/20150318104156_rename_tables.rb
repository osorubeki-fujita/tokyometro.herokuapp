class RenameTables < ActiveRecord::Migration
  def change
    rename_table :air_conditioners , :air_conditioner_infos
    rename_table :barrier_free_facilities , :barrier_free_facility_infos
    rename_column :barrier_free_facility_root_infos , :barrier_free_facility_id , :barrier_free_facility_info_id
rename_column :barrier_free_facility_service_details , :barrier_free_facility_id , :barrier_free_facility_info_id
rename_column :barrier_free_facility_toilet_assistants , :barrier_free_facility_id , :barrier_free_facility_info_id
rename_column :station_facility_platform_info_barrier_free_facilities , :barrier_free_facility_id , :barrier_free_facility_info_id
  end
end