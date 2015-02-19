# 丸ノ内支線に関連する情報を変換するための機能を提供するモジュール
# @note API からの情報の修正
# @note {::TokyoMetro::Api::StationTimetable::Info} に対する機能
module TokyoMetro::Modules::Api::Convert::Patches::StationTimetable::NakanoSakaueOnMarunouchiBranchLine::Info

  # Constructor
  # @note {::TokyoMetro::Api::StationTimetable::Info#.initialize} に機能を追加する。
  # @return [::TokyoMetro::Api::StationTimetable::Info]
  def initialize( *variables )
    super( *variables )
    convert_infos_related_to_nakano_sakaue_on_marunouchi_branch_line
  end

  private

  # 「丸ノ内支線 中野坂上駅からの方南町方面の時刻表」に関する処理
  # @return [nil]
  # @note 誤：
  #   @same_as == "odpt.StationTimetable:TokyoMetro.Marunouchi.NakanoSakaue.Honancho" - 「丸ノ内線 中野坂上駅からの方南町方面の時刻表」
  # @note 正：
  #   @same_as == "odpt.StationTimetable:TokyoMetro.MarunouchiBranch.NakanoSakaue.Honancho" - 「丸ノ内支線 中野坂上駅からの方南町方面の時刻表」
  def convert_infos_related_to_nakano_sakaue_on_marunouchi_branch_line
    if at_nakano_sakaue?
      if same_as?( "odpt.StationTimetable:TokyoMetro.Marunouchi.NakanoSakaue.Honancho" )
        @same_as = "odpt.StationTimetable:TokyoMetro.MarunouchiBranch.NakanoSakaue.Honancho"
      end
    end
    return nil
  end

end