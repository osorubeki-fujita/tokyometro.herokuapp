# 駅のバリアフリー施設を扱うクラス ug:SpatialThing
class TokyoMetro::Api::StationFacility::Info::BarrierFree

  # バリアフリー施設のインスタンスを作成するメソッド
  # @param facility_hash [Hash] バリアフリー情報が格納されたハッシュ
  # @return [sub-classes of BarrierFree::Info]
  # @note 下位名前空間のクラスのインスタンスを作成する。
  def self.generate_from_hash( facility_hash )
    class_name_const = class_name( facility_hash )
    class_name_const.generate_from_hash( facility_hash )
  end

  # クラスメソッド generate_from_hash を呼び出すクラスの設定
  # @param facility_hash [Hash] バリアフリー情報が格納されたハッシュ
  # @return [Const (class name)]
  def self.class_name( facility_hash )
    case facility_hash[ "\@type" ]

    when "ug:Toilet"
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Info

    when "spac:Stairlift"
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Stairlift::Info

    when "ug:Elevator"
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Elevator::Info

    when "ug:Escalator"
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::Info

    when "ug:Link"
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::LinkForMobilityScooter::Info

    else
      raise "Error"
    end
  end

  private_class_method :class_name

end