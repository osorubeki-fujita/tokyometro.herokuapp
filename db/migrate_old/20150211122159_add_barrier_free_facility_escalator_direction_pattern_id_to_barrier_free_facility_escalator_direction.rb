class AddBarrierFreeFacilityEscalatorDirectionPatternIdToBarrierFreeFacilityEscalatorDirection < ActiveRecord::Migration
  def change
    add_column :barrier_free_facility_escalator_directions, :barrier_free_facility_escalator_direction_pattern_id, :integer
  end
end
