class RenameNameInSurroundingAreaToNameJa < ActiveRecord::Migration
  def change

    rename_column :surrounding_areas , :name , :name_ja

    #----

    rename_table :station_facilities , :station_facility_infos

    rename_column :barrier_free_facility_infos , :station_facility_id , :station_facility_info_id
    rename_column :point_infos , :station_facility_id , :station_facility_info_id
    rename_column :station_facility_aliases , :station_facility_id , :station_facility_info_id
    rename_column :station_facility_platform_infos , :station_facility_id , :station_facility_info_id
    rename_column :station_infos , :station_facility_id , :station_facility_info_id

  end
end
