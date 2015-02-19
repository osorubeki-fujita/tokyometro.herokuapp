# 路線名のリストを定数・モジュール関数として提供する名前空間
module TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  class << self

    def railway_line_string_list_in_system( *ary )
      ary.flatten.map { | method_name |
        case method_name
        when :marunouchi_including_branch , :chiyoda_including_branch , :yurakucho_or_fukutoshin , :yurakucho_and_fukutoshin , :namboku_or_toei_mita , :namboku_and_toei_mita
          self.send( method_name )
        else
          ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.send( method_name )
        end
      }
    end

    def railway_line_same_as( *ary )
      ary.flatten.map { | railway_line | "odpt.Railway:TokyoMetro.#{railway_line}" }
    end

  end

  # @!group 丸ノ内線、丸ノ内支線の名称

  # @example
  #   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.marunouchi_main_and_branch_line_in_system => [
  #     "Marunouchi",
  #     "MarunouchiBranch"
  #   ]
  MARUNOUCHI_MAIN_AND_BRANCH_LINE_IN_SYSTEM = railway_line_string_list_in_system( :marunouchi_in_system , :marunouchi_branch_in_system )

  # @example
  #   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.marunouchi_main_and_branch_line_same_as => [
  #     "odpt.Railway:TokyoMetro.Marunouchi",
  #     "odpt.Railway:TokyoMetro.MarunouchiBranch"
  #   ]
  MARUNOUCHI_MAIN_AND_BRANCH_LINE_SAME_AS = railway_line_same_as( MARUNOUCHI_MAIN_AND_BRANCH_LINE_IN_SYSTEM )

  # @!group 千代田線（本線）、北綾瀬支線の名称

  # @example
  #   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.chiyoda_main_and_branch_line_in_system => [
  #     "Chiyoda",
  #     "ChiyodaBranch"
  #   ]
  CHIYODA_MAIN_AND_BRANCH_LINE_IN_SYSTEM = railway_line_string_list_in_system( :chiyoda_in_system , :chiyoda_branch_in_system )

  # @example
  #   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.chiyoda_main_and_branch_line_same_as => [
  #     "odpt.Railway:TokyoMetro.Chiyoda",
  #     "odpt.Railway:TokyoMetro.ChiyodaBranch"
  #   ]
  CHIYODA_MAIN_AND_BRANCH_LINE_SAME_AS = railway_line_same_as( CHIYODA_MAIN_AND_BRANCH_LINE_IN_SYSTEM )

  # @!group 有楽町線、副都心線の名称

  # @example
  #   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_in_system => [
  #     "Yurakucho",
  #     "Fukutoshin"
  #   ]
  YURAKUCHO_AND_FUKUTOSHIN_LINE_IN_SYSTEM = railway_line_string_list_in_system( :yurakucho_in_system , :fukutoshin_in_system )

  # @example
  #   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_same_as => [
  #     "odpt.Railway:TokyoMetro.Yurakucho",
  #     "odpt.Railway:TokyoMetro.Fukutoshin"
  #   ]
  YURAKUCHO_AND_FUKUTOSHIN_LINE_SAME_AS = railway_line_same_as( YURAKUCHO_AND_FUKUTOSHIN_LINE_IN_SYSTEM )

  # @!group 南北線、都営三田線の名称

  # @example
  #   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.namboku_and_toei_mita_line_same_as => [
  #     "odpt.Railway:TokyoMetro.Namboku",
  #     "odpt.Railway:Toei.Mita"
  #   ]
  NAMBOKU_AND_TOEI_MITA_LINE_SAME_AS = [ "odpt.Railway:TokyoMetro.Namboku" , "odpt.Railway:Toei.Mita" ]

  # @!endgroup

  def self.marunouchi_including_branch
    MARUNOUCHI_MAIN_AND_BRANCH_LINE_SAME_AS
  end

  def self.chiyoda_including_branch
    CHIYODA_MAIN_AND_BRANCH_LINE_SAME_AS
  end

  def self.yurakucho_and_fukutoshin
    YURAKUCHO_AND_FUKUTOSHIN_LINE_SAME_AS
  end

  def self.namboku_and_toei_mita
    NAMBOKU_AND_TOEI_MITA_LINE_SAME_AS
  end

  class << self
    alias :yurakucho_or_fukutoshin :yurakucho_and_fukutoshin
    alias :namboku_or_toei_mita :namboku_and_toei_mita
  end

end