# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Escalator::ServiceDetail::Info < TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::ServiceDetail::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  def variables
    super + [ direction_of_escalator ]
  end

  def self.instance_class
    escalator_service_detail_info_class
  end

  private

  def direction_of_escalator
    self.class.escalator_service_detail_direction_class.generate_from_hash( @hash[ "ug:direction" ] )
  end

end