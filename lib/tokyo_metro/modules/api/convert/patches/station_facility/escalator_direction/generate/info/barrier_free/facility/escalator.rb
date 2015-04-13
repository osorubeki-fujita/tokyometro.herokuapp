# 駅施設情報内部のエスカレーターに関する不正確な情報を修正する機能を提供するモジュール
# @note {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection.set_modules} により {TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Escalator} へ include する。
# @note {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection::Generate::Info::BarrierFree::Facility::Escalator::ServiceDetail::ChiyodaOtemachiOutsideEscalator1} は、TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection::Generate::Info::BarrierFree::Facility::Escalator#service_detail の内部変数に対し、特異メソッドを追加するために prepend される。
module TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection::Generate::Info::BarrierFree::Facility::Escalator

  CHIYODA_OTEMACHI_OUTSIDE_ESCALATOR_1 = "odpt.StationFacility:TokyoMetro.Chiyoda.Otemachi.Outside.Escalator.1"

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  private

  def service_details
    case @hash[ "owl:sameAs" ]
    when CHIYODA_OTEMACHI_OUTSIDE_ESCALATOR_1
      service_detail_ary_new = @hash[ "odpt:serviceDetail" ].map { | info_h |
        factory_instance = self.class.factory_for_generating_barrier_free_escalator_service_detail_from_hash.new( info_h )
        # puts "★ " + @hash[ "owl:sameAs" ]

        class << factory_instance
          prepend ::TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection::Generate::Info::BarrierFree::Facility::Escalator::ServiceDetail::ChiyodaOtemachiOutsideEscalator1
        end

        factory_instance.generate
      }
      self.class.barrier_free_service_detail_list_class.new( service_detail_ary_new )
    else
      super
    end
  end

end