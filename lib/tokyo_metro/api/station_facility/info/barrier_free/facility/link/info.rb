# ハンドル型電動車いす利用可能経路の情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Link::Info < TokyoMetro::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Link

  # @!group 車いすの利用に関するメソッド

  # ハンドル型電動車いすが利用可能か否かを判定するメソッド
  # @return [Boolean]
  # @note すべて true
  def available_to_mobility_scooter?
    true
  end

  # 一般的な車いすが利用可能か否かを判定するメソッド
  # @return [Boolean]
  # @note すべて true（ハンドル型電動車いすが利用可能であれば一般的な車いすも利用可能であろう、という推論ベース）
  def available_to_wheel_chair?
    true
  end

  alias :is_available_to_wheel_chair :available_to_wheel_chair?
  alias :is_available_to_mobility_scooter :available_to_mobility_scooter?

  # @!endgroup

end