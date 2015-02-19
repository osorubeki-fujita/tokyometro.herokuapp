# 千代田線大手町駅のエスカレーター odpt.StationFacility:TokyoMetro.Chiyoda.Otemachi.Outside.Escalator.1 の方向に関する情報を扱うモジュール
# @note {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection::Generate::Info::BarrierFree::Facility::Escalator}#service_detail の内部で、変数に対し、特異メソッドを追加するために prepend される。
module TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection::Generate::Info::BarrierFree::Facility::Escalator::ServiceDetail::ChiyodaOtemachiOutsideEscalator1

  private

  # 千代田線大手町駅のエスカレーター odpt.StationFacility:TokyoMetro.Chiyoda.Otemachi.Outside.Escalator.1 の方向
  # @note 上りのみ
  # @return [::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction]
  def direction_of_escalator
    self.class.escalator_service_detail_direction_class.new( true , false )
  end

end

# Complete: 2014/12/27 10:17