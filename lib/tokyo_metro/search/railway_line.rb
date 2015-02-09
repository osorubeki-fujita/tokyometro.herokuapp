# 路線に関する情報を検索するモジュール
module TokyoMetro::Search::RailwayLine

  def self.name_in_api( railway_line_name )
    if railway_line_name.string? and / *[lL]ine *\Z/ === railway_line_name
      railway_line_name = railway_line_name.gsub( / *[lL]ine *\Z/ , "" )
    end

    ::TokyoMetro::Static.railway_lines_operated_by_tokyo_metro.each do | item |
      if [ item[ "name" ] , item[ "name_en" ] , item[ "odpt:railway" ] , item[ "name_code" ] ].include?( railway_line_name )
        return item[ "odpt:railway" ]
      end
    end
    ""
  end

  # 路線の一般名称
  # @param railway_line_name [String] 路線名称（例：odpt.Railway:TokyoMetro.Marunouchi、銀座線、T、Mita）
  # @return [String]
  def self.normal_name( railway_line_name )
    railway_line_same_as = name_in_api( railway_line_name )
    ::TokyoMetro::Static.railway_lines_operated_by_tokyo_metro.each do | item |
      if item[ "odpt:railway" ] == railway_line_same_as
        return item[ "name" ]
      end
    end
    ""
  end

  # 路線色 (Web Color)
  # @param railway_line_name [String] 路線名称（例：odpt.Railway:TokyoMetro.Marunouchi、銀座線、T、Mita）
  # @return [String]
  def self.web_color( railway_line_name )
    railway_line_same_as = name_in_api( railway_line_name )
    ::TokyoMetro::Static.railway_lines_operated_by_tokyo_metro.each do | item |
      if item[ "odpt:railway" ] == railway_line_same_as
        return item[ "color" ][ "web" ]
      end
    end
    "\#999999"
  end

  # 路線記号
  # @param railway_line_name [String] 路線名称（例：odpt.Railway:TokyoMetro.Marunouchi、銀座線、T、Mita）
  # @return [String]
  def self.name_code( railway_line_name )
    railway_line_same_as = name_in_api( railway_line_name )
    ::TokyoMetro::Static.railway_lines_operated_by_tokyo_metro.each do | item |
      if item[ "odpt:railway" ] == railway_line_same_as
        return item[ "name_code" ]
      end
    end
    ""
  end

  # 路線番号
  # @param railway_line_name [String] 路線名称（例：odpt.Railway:TokyoMetro.Marunouchi、銀座線、T、Mita）
  # @return [String]
  # @note 建設順
  def self.railway_line_order( railway_line_name )
    railway_line_same_as = name_in_api( railway_line_name )
    ::TokyoMetro::Static.railway_lines_operated_by_tokyo_metro.each do | item |
      if item[ "odpt:railway" ] == railway_line_same_as
        return item[ "number" ]
      end
    end
    999
  end

  # CSS ファイル内で路線情報に付加するクラス名
  # @param railway_line_name [String] 路線名称（例：odpt.Railway:TokyoMetro.Marunouchi、銀座線、T、Mita）
  # @return [String]
  def self.color_in_css_class( railway_line_name )
    railway_line_same_as = name_in_api( railway_line_name )
    railway_line_code = name_code( railway_line_same_as )
    case railway_line_code
    when ""
      "normal_line"
    else
      "subway_#{railway_line_code.downcase}"
    end
  end

end