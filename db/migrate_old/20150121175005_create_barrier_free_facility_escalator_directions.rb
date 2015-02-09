class CreateBarrierFreeFacilityEscalatorDirections < ActiveRecord::Migration
  def change
    create_table :barrier_free_facility_escalator_directions do |t|
      t.integer :barrier_free_facility_service_detail_id
      t.boolean :up
      t.boolean :down

      t.timestamps
    end
  end
end
