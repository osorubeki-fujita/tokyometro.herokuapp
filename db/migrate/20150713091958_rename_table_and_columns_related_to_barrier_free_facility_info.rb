class RenameTableAndColumnsRelatedToBarrierFreeFacilityInfo < ActiveRecord::Migration
  def change
    rename_column :barrier_free_facility_infos , :barrier_free_facility_type_id , :type_id
    rename_column :barrier_free_facility_infos , :barrier_free_facility_located_area_id ,  :located_area_id
  end
end
