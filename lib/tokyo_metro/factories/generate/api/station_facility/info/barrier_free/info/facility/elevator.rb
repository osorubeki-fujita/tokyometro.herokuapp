class TokyoMetro::Factories::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Elevator < TokyoMetro::Factories::Generate::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Elevator

  def self.instance_class
    barrier_free_elevator_info_class
  end

end