module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::MobilityScooter::Availability::None

  # ハンドル型電動車いすが利用可能か否かを判定するメソッド
  # @return [Boolean]
  # @note 現段階ではすべて false とする。
  # @todo true のものがあるか否かを調べる。
  def is_available_to_mobility_scooter
    false
  end

end