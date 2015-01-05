module TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  # @!group 丸ノ内線、丸ノ内支線

  ::TokyoMetro::CommonModules::Dictionary::Station::StringList.between_honancho_and_nakano_shimbashi_in_system.each do | base_name |
    const_set(
      eval( ":#{ base_name.underscore.upcase }_INCLUDING_INVALID" ) ,
      /\Aodpt\.Station\:TokyoMetro\.Marunouchi(?:Branch)?\.#{ base_name }\Z/
    )
  end

  NAKANO_SAKAUE = /Marunouchi(?:Branch)?\.NakanoSakaue\Z/

  # @!group 有楽町線・副都心線

  ::TokyoMetro::CommonModules::Dictionary::Station::StringList.between_wakoshi_and_kanamecho_in_system.each do | base_name |
    const_set(
      eval( ":#{base_name.to_s.underscore.upcase}" ) ,
      /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.#{ base_name.to_s.camelize }\Z/
    )
  end

  IKEBUKURO_ON_YURAKUCHO_OR_FUKUTOSHIN_LINE = /TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Ikebukuro\Z/

  # @!endgroup

end