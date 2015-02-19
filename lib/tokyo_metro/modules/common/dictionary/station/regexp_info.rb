# 駅名の正規表現を定数・モジュール関数として提供する名前空間
# @example
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.honancho_including_invalid            => /\Aodpt\.Station\:TokyoMetro\.Marunouchi(?:Branch)?\.Honancho\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.nakano_fujimicho_including_invalid    => /\Aodpt\.Station\:TokyoMetro\.Marunouchi(?:Branch)?\.NakanoFujimicho\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.nakano_shimbashi_including_invalid    => /\Aodpt\.Station\:TokyoMetro\.Marunouchi(?:Branch)?\.NakanoShimbashi\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.nakano_sakaue                         => /\Aodpt\.Station\:TokyoMetro\.Marunouchi(?:Branch)?\.NakanoSakaue\Z/
#
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.ayase                                 => /\Aodpt\.Station\:TokyoMetro\.Chiyoda(?:Branch)?\.Ayase\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.kita_ayase                            => /\Aodpt\.Station\:TokyoMetro\.Chiyoda(?:Branch)?\.KitaAyase\Z/
#
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.wakoshi                               => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Wakoshi\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.chikatetsu_narimasu                   => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.ChikatetsuNarimasu\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.chikatetsu_akatsuka                   => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.ChikatetsuAkatsuka\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.heiwadai                              => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Heiwadai\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.hikawadai                             => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Hikawadai\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.kotake_mukaihara                      => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.KotakeMukaihara\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.senkawa                               => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Senkawa\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.kanamecho                             => /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Kanamecho\Z/
#   TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.ikebukuro_on_yurakucho_or_fukutoshin_line => /TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Ikebukuro\Z/
module TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  # @!group 丸ノ内線、丸ノ内支線

  ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_shimbashi_in_system.each do | base_name |
    const_set(
      eval( ":#{ base_name.underscore.upcase }_INCLUDING_INVALID" ) ,
      /\Aodpt\.Station\:TokyoMetro\.Marunouchi(?:Branch)?\.#{ base_name }\Z/
    )
  end

  NAKANO_SAKAUE = /\Aodpt\.Station\:TokyoMetro\.Marunouchi(?:Branch)?\.NakanoSakaue\Z/

  # @!group 千代田線
  AYASE = /\Aodpt\.Station\:TokyoMetro\.Chiyoda(?:Branch)?\.Ayase\Z/
  KITA_AYASE = /\Aodpt\.Station\:TokyoMetro\.Chiyoda(?:Branch)?\.KitaAyase\Z/

  # @!group 有楽町線・副都心線

  ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_kanamecho_in_system.each do | base_name |
    const_set(
      eval( ":#{base_name.to_s.underscore.upcase}" ) ,
      /\Aodpt\.Station\:TokyoMetro\.(?:Yurakucho|Fukutoshin)\.#{ base_name.to_s.camelize }\Z/
    )
  end

  IKEBUKURO_ON_YURAKUCHO_OR_FUKUTOSHIN_LINE = /TokyoMetro\.(?:Yurakucho|Fukutoshin)\.Ikebukuro\Z/

  # @!endgroup

end