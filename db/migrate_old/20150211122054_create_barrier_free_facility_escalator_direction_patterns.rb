class CreateBarrierFreeFacilityEscalatorDirectionPatterns < ActiveRecord::Migration
  def change
    create_table :barrier_free_facility_escalator_direction_patterns do |t|
      t.boolean :up
      t.boolean :down

      t.timestamps
    end
  end
end
