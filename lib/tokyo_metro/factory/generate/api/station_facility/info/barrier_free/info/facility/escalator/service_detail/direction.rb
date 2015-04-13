# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Escalator::ServiceDetail::Direction < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  def initialize( var )
    raise "Error" if var.nil?
    super( var )
  end

  def variables
    [ up , down ]
  end

  def self.instance_class
    escalator_service_detail_direction_class
  end

  private

  def up
    /上り/ === @string
  end

  def down
    /下り/ === @string
  end

end