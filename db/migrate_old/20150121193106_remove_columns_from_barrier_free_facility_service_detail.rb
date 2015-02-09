class RemoveColumnsFromBarrierFreeFacilityServiceDetail < ActiveRecord::Migration
  def change
    remove_column :barrier_free_facility_service_detail_patterns , :escalator_direction_up
    remove_column :barrier_free_facility_service_detail_patterns , :escalator_direction_down
  end
end
