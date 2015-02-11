class RenameWheelchairAccessibleInBarierFreeFacilityToiletAssistantPatternToWheelChairAccessible < ActiveRecord::Migration
  def change
    rename_column :barrier_free_facility_toilet_assistant_patterns , :wheelchair_accessible , :wheel_chair_accessible
  end
end
