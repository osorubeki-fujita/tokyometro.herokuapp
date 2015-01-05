module TokyoMetro::CommonModules::Dictionary::RailwayLine::StringList

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  class << self

    def railway_line_string_list_in_system( *ary )
      ary.flatten.map { | method_name | ::TokyoMetro::CommonModules::Dictionary::RailwayLine::StringInfo.send( method_name ) }
    end

    def railway_line_same_as( *ary )
      ary.flatten.map { | railway_line | "odpt.Railway:TokyoMetro.#{railway_line}" }
    end

  end

  # @!group 丸ノ内線、丸ノ内支線の名称

  MARUNOUCHI_MAIN_AND_BRANCH_LINE_IN_SYSTEM = railway_line_string_list_in_system( :marunouchi_in_system , :marunouchi_branch_in_system )
  MARUNOUCHI_MAIN_AND_BRANCH_LINE_SAME_AS = railway_line_same_as( MARUNOUCHI_MAIN_AND_BRANCH_LINE_IN_SYSTEM )

  # @!group 千代田線（本線）、北綾瀬支線の名称

  CHIYODA_MAIN_AND_BRANCH_LINE_IN_SYSTEM = railway_line_string_list_in_system( :chiyoda_in_system , :chiyoda_branch_in_system )
  CHIYODA_MAIN_AND_BRANCH_LINE_SAME_AS = railway_line_same_as( CHIYODA_MAIN_AND_BRANCH_LINE_IN_SYSTEM )

  # @!group 有楽町線、副都心線の名称

  YURAKUCHO_AND_FUKUTOSHIN_LINE_IN_SYSTEM = railway_line_string_list_in_system( :yurakucho_in_system , :fukutoshin_in_system )
  YURAKUCHO_AND_FUKUTOSHIN_LINE_SAME_AS = railway_line_same_as( YURAKUCHO_AND_FUKUTOSHIN_LINE_IN_SYSTEM )

  # @!endgroup

end