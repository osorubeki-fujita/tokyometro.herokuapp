# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail < TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::ServiceDetail

  def initialize(h)
    super(h)
  end

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  def variables
    [ super , direction_of_escalator ].flatten(1)
  end

  private

  def direction_of_escalator
    direction_str = @hash[ "ug:direction" ]
    self.class.service_detail_direction_class.generate_from_string( direction_str )
  end

end