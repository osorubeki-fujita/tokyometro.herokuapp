class RenameStationFacilityAlias < ActiveRecord::Migration
  def change
    rename_table :station_facility_aliases , :station_facility_name_aliases
  end
end
