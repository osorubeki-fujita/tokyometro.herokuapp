# 路線名の正規表現を定数・モジュール関数として提供する名前空間
# @example
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.ginza_line                        => (?-mix:TokyoMetro\.Ginza)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.marunouchi_line                   => (?-mix:TokyoMetro\.Marunouchi)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.marunouchi_branch_line            => (?-mix:TokyoMetro\.MarunouchiBranch)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.hibiya_line                       => (?-mix:TokyoMetro\.Hibiya)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.tozai_line                        => (?-mix:TokyoMetro\.Tozai)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.chiyoda_line                      => (?-mix:TokyoMetro\.Chiyoda)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.chiyoda_branch_line               => (?-mix:TokyoMetro\.ChiyodaBranch)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.yurakucho_line                    => (?-mix:TokyoMetro\.Yurakucho)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.hanzomon_line                     => (?-mix:TokyoMetro\.Hanzomon)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.namboku_line                      => (?-mix:TokyoMetro\.Namboku)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.fukutoshin_line                   => (?-mix:TokyoMetro\.Fukutoshin)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.marunouchi_line_including_branch  => (?-mix:TokyoMetro\.Marunouchi(?:Branch)?\.)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.tobu_main_line                    => (?-mix:Tobu\.(?:SkyTree|Isesaki|SkyTreeOshiage|Nikko))
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.tokyu_den_en_toshi_line           => (?-mix:Tokyu\.DenEnToshi)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.toyo_rapid_line                   => (?-mix:ToyoRapidRailway\.ToyoRapid)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.odakyu_line                       => (?-mix:Odakyu\.(?:Odawara|Tama|Enoshima))
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.odakyu_tama_line                  => (?-mix:Odakyu\.Tama)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.hakone_tozan_line                 => (?-mix:HakoneTozan\.Rail)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.jr_joban_line                     => (?-mix:JR\-East\.Joban)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.toei_mita_line                    => (?-mix:Toei\.Mita)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.tokyu_meguro_line                 => (?-mix:Tokyu\.Meguro)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.saitama_railway_line              => (?-mix:SaitamaRailway\.SaitamaRailway)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.seibu_line                        => (?-mix:Seibu\.Ikebukuro)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.tobu_tojo_line                    => (?-mix:Tobu\.Tojo)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.tokyu_toyoko_line                 => (?-mix:Tokyu\.Toyoko)
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.minatomirai_line                  => (?-mix:YokohamaMinatomiraiRailway\.Minatomirai)
module TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  # @!group 東京メトロ各線

  ::YAML.load_file( "#{ ::TokyoMetro.dictionary_dir }/railway_line/tokyo_metro_lines_in_system.yaml" ).each do | item |
    const_set( eval( ":#{ item.underscore.upcase }_LINE" ) , /TokyoMetro\.#{ item }/ )
  end

  # @!group 丸ノ内線

  MARUNOUCHI_LINE_INCLUDING_BRANCH = /TokyoMetro\.Marunouchi(?:Branch)?\./

  # @!group 日比谷線・半蔵門線

  TOBU_MAIN_LINE = /Tobu\.(?:SkyTree|Isesaki|SkyTreeOshiage|Nikko)/
  TOKYU_DEN_EN_TOSHI_LINE = /Tokyu\.DenEnToshi/

  # @!group 東西線

  TOYO_RAPID_LINE = /ToyoRapidRailway\.ToyoRapid/

  # @!group 千代田線

  ODAKYU_LINE = /Odakyu\.(?:Odawara|Tama|Enoshima)/
  ODAKYU_TAMA_LINE = /Odakyu\.Tama/
  HAKONE_TOZAN_LINE = /HakoneTozan\.Rail/
  JR_JOBAN_LINE = /JR\-East\.Joban/

  # @!group 南北線

  TOEI_MITA_LINE = /Toei\.Mita/
  TOKYU_MEGURO_LINE = /Tokyu\.Meguro/
  SAITAMA_RAILWAY_LINE = /SaitamaRailway\.SaitamaRailway/

  # @!group 有楽町線・副都心線

  SEIBU_LINE = /Seibu\.Ikebukuro/
  TOBU_TOJO_LINE = /Tobu\.Tojo/
  TOKYU_TOYOKO_LINE = /Tokyu\.Toyoko/
  MINATOMIRAI_LINE = /YokohamaMinatomiraiRailway\.Minatomirai/

end