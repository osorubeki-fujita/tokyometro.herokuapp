class TokyoMetro::Factories::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Link < TokyoMetro::Factories::Generate::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Link

  def self.instance_class
    barrier_free_link_info_class
  end

end