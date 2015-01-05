# エレベータの情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Elevator::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Elevator

  def self.generate_from_hash( facility_hash )
    super( facility_hash )
  end

end