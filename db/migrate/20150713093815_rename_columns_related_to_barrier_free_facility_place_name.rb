class RenameColumnsRelatedToBarrierFreeFacilityPlaceName < ActiveRecord::Migration
  def change
    rename_column :barrier_free_facility_root_infos , :barrier_free_facility_info_id , :info_id
    rename_column :barrier_free_facility_root_infos , :barrier_free_facility_place_name_id , :place_name_id
  end
end
