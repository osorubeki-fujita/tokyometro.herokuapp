class Station::Facility::NameAlias < ActiveRecord::Base
  belongs_to :station_facility_info , class: ::Station::Facility::Info
end
