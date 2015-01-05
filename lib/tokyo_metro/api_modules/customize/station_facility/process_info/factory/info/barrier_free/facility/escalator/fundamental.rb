# 駅施設情報内部のエスカレーターに関する不正確な情報を修正する機能を提供するモジュール
# @note {TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo.set_modules} により {TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Escalator} へ include する。
# @note {TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Factory::Info::BarrierFree::Facility::Escalator::ServiceDetail::ChiyodaOtemachiOutsideEscalator1} は、TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Factory::Info::BarrierFree::Facility::Escalator::Fundamental#service_detail の内部変数に対し、特異メソッドを追加するために prepend される。
module TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Factory::Info::BarrierFree::Facility::Escalator::Fundamental

  CHIYODA_OTEMACHI_OUTSIDE_ESCALATOR_1 = "odpt.StationFacility:TokyoMetro.Chiyoda.Otemachi.Outside.Escalator.1"

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  private

  def service_detail
    case @hash[ "owl:sameAs" ]
    when self.class.chiyoda_otemachi_outside_escalator_1
      service_detail_ary_new = @hash[ "odpt:serviceDetail" ].map { | info_h |
        factory_instance = self.class.factory_of_service_detail.new( info_h )

        class << factory_instance
          prepend ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Factory::Info::BarrierFree::Facility::Escalator::ServiceDetail::ChiyodaOtemachiOutsideEscalator1
        end

        factory_instance.generate
      }
      self.class.service_detail_list_class.new( service_detail_ary_new )
    else
      super
    end
  end

end