class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::MetaClass::LinkForMobilityScooterAndStairlift::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::Accessibility::All
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::Accessibility::AliasTowardsAvailability
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::WheelChair::MethodMissing

  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::MobilityScooter::Accessibility::All
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::MobilityScooter::Accessibility::AliasTowardsAvailability
  include ::TokyoMetro::CommonModules::Info::StationFacility::BarrierFree::MobilityScooter::MethodMissing

end