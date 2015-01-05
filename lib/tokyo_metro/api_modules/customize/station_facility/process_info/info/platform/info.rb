# 駅施設情報内部のプラットホーム情報の不正確な情報を修正する機能を提供するモジュール
# @note {TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo.set_modules} により {TokyoMetro::Api::StationFacility::Info::Platform::Info} へ include する。
# @note {TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::BarrierFree::Info} でも同様の名称変更を行う。
module TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::Platform::Info

  # Constructor
  def initialize( railway_line , car_composition , car_number , railway_direction , transfer_informations , barrier_free_facilities , surrounding_areas )
    super
    process_invalid_barrier_free_facilitiy_names
  end

  private

  def process_invalid_barrier_free_facilitiy_names
    if @barrier_free_facilities.present? and @barrier_free_facilities.include?( ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::BarrierFree::Info.invalid_toilet_name_of_outside_toilet_in_nakano_shimbashi )
      ary = ::Array.new
      @barrier_free_facilities.each do | facility |
        if facility == ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::BarrierFree::Info.invalid_toilet_name_of_outside_toilet_in_nakano_shimbashi
          ary << ::TokyoMetro::ApiModules::Customize::StationFacility::ProcessInfo::Info::BarrierFree::Info.valid_toilet_name_of_inside_toilet_in_nakano_shimbashi
        else
          ary << facility
        end
      end
      @barrier_free_facilities = ary
    end
  end

end