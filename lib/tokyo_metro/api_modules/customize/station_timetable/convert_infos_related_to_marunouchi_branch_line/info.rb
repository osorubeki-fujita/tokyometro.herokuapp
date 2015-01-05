# 丸ノ内支線に関連する情報を変換するための機能を提供するモジュール
# @note API からの情報の修正
# @note {::TokyoMetro::Api::StationTimetable::Info} に対する機能
module TokyoMetro::ApiModules::Customize::StationTimetable::ConvertInfosRelatedToMarunouchiBranchLine::Info

  # Constructor
  # @note {::TokyoMetro::Api::StationTimetable::Info#.initialize} に機能を追加する。
  # @return [::TokyoMetro::Api::StationTimetable::Info]
  def initialize( id_urn , same_as , dc_date , station , railway_line , operator , railway_direction , 
    weekdays , saturdays , holidays
  )
    super
    convert_infos_related_to_marunouchi_branch_line
  end

  private

  # 「丸ノ内支線 中野坂上駅からの方南町方面の時刻表」に関する処理
  # @return [nil]
  # @note 誤：
  #   @same_as == "odpt.StationTimetable:TokyoMetro.Marunouchi.NakanoSakaue.Honancho" - 「丸ノ内線 中野坂上駅からの方南町方面の時刻表」
  #   @station == "odpt.StationTimetable:TokyoMetro.Marunouchi.NakanoSakaue" - 「丸ノ内線 中野坂上駅」
  # @note 正：
  #   @same_as == "odpt.StationTimetable:TokyoMetro.MarunouchiBranch.NakanoSakaue.Honancho" - 「丸ノ内支線 中野坂上駅からの方南町方面の時刻表」
  #   @station == "odpt.StationTimetable:TokyoMetro.MarunouchiBranch.NakanoSakaue" - 「丸ノ内支線 中野坂上駅」
  def convert_infos_related_to_marunouchi_branch_line
    if at_nakano_sakaue?
      if @same_as == "odpt.StationTimetable:TokyoMetro.Marunouchi.NakanoSakaue.Honancho"
        @same_as = "odpt.StationTimetable:TokyoMetro.MarunouchiBranch.NakanoSakaue.Honancho"
        @station = "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue"

        # @railway_line は、方南町、中野富士見町、中野新橋も含め "odpt.Railway:TokyoMetro.Marunouchi" で統一されている。
        # @railway_line = "odpt.Railway:TokyoMetro.Marunouchi"
      end
    end
    return nil
  end

end