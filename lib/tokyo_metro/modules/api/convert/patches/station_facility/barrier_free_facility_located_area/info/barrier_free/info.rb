# 駅施設情報の不正確な情報を修正する機能を提供するモジュール
# @note {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::EscalatorDirection.set_modules} により {TokyoMetro::Api::StationFacility::Info::BarrierFree::Info} へ include する。
# @note {TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::Platform::Info} でも同様の名称変更を行う。
# @example
#   TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::BarrierFree::Info.invalid_toilet_name_of_outside_toilet_in_nakano_shimbashi
#     => "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Outside.Toilet.1"
#   TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::BarrierFree::Info.valid_toilet_name_of_inside_toilet_in_nakano_shimbashi
#     => "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Inside.Toilet.1"
module TokyoMetro::Modules::Api::Convert::Patches::StationFacility::BarrierFreeFacilityLocatedArea::Info::BarrierFree::Info

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  # 中野新橋駅のトイレ - 不正確な名称（改札外）
  # @return [String]
  INVALID_TOILET_NAME_OF_OUTSIDE_TOILET_IN_NAKANO_SHIMBASHI = "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Outside.Toilet.1"

  # 中野新橋駅のトイレ - 正確な名称（改札内）
  # @return [String]
  VALID_TOILET_NAME_OF_INSIDE_TOILET_IN_NAKANO_SHIMBASHI = "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Inside.Toilet.1"

  # Constructor
  def initialize( id_urn , same_as , service_detail , place_name , located_area_name , remark )
    super
    process_invalid_located_area
  end

  private

  def process_invalid_located_area
    case @same_as
    when "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Outside.Toilet.1"
      if outside?
        @located_area_name == "改札内"
        @same_as = "odpt.StationFacility:TokyoMetro.Marunouchi.NakanoShimbashi.Inside.Toilet.1"
      end
    end
  end

end