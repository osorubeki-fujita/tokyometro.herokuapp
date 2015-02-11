class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :barrier_free_facility_escalator_directions , :up
    remove_column :barrier_free_facility_escalator_directions , :down
  end
end
