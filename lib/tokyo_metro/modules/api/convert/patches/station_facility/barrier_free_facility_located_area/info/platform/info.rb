# 駅施設情報内部のプラットホーム情報の不正確な情報を修正する機能を提供するモジュール
# @note {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection.set_modules} により {TokyoMetro::Api::StationFacility::Info::Platform::Info} へ include する。
# @note {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::BarrierFree::Info} でも同様の名称変更を行う。
module TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::Platform::Info

  # Constructor
  def initialize( *variables )
    super( *variables )
    process_invalid_barrier_free_facilitiy_names
  end

  private

  def process_invalid_barrier_free_facilitiy_names
    dictionary_namespace = ::TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::BarrierFree::Info
    invalid_name = dictionary_namespace.invalid_toilet_name_of_outside_toilet_in_nakano_shimbashi
    if @barrier_free_facilities.present? and @barrier_free_facilities.any?{ | item | item.facility == invalid_name }
      ary = ::Array.new
      @barrier_free_facilities.each do | item |

        if item.facility == invalid_name
          item.instance_eval do
            @facility = dictionary_namespace.valid_toilet_name_of_inside_toilet_in_nakano_shimbashi
          end
        end

      end
    end
  end

end