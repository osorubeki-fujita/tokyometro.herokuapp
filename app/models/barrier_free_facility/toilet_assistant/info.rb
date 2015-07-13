class BarrierFreeFacility::ToiletAssistant::Info < ActiveRecord::Base
  belongs_to :info , class: ::BarrierFreeFacility::Info
  belongs_to :pattern , class: ::BarrierFreeFacility::ToiletAssistant::Pattern

  scope :station_facility_info , ->{
    info.station_facility_info
  }

end
