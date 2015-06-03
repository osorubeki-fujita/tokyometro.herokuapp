class StationFacility::NameAlias < ActiveRecord::Base
  belongs_to :station_facility_info , class: ::StationFacility::Info
end
