# エスカレータの情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  # Constructor
  def initialize( id_urn , same_as , service_detail , place_name , located_area_name , remark , is_available_to_wheel_chair )
    super( id_urn , same_as , service_detail , place_name , located_area_name , remark )
    @is_available_to_wheel_chair = is_available_to_wheel_chair
  end

  # @return [String] エスカレータの方向名（施設がエスカレータの場合に格納。上り、下り、上り・下りの3種類が存在）
  attr_reader :direction
  # @return [Boolean] 一般的な車いすが利用可能か否か
  attr_reader :is_available_to_wheel_chair

  # @!group 車いすの利用に関するメソッド

  # ハンドル型電動車いすが利用可能か否かを判定するメソッド
  # @return [Boolean]
  # @note 現段階ではすべて false とする。
  # @todo true のものがあるか否かを調べる。
  def available_to_mobility_scooter?
    false
  end

  alias :available_to_wheel_chair? :is_available_to_wheel_chair
  alias :is_available_to_mobility_scooter :available_to_mobility_scooter?

  def self.factory_for_this_class
    factory_for_generating_barrier_free_escalator_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_barrier_free_facility_escalator_info
  end

end