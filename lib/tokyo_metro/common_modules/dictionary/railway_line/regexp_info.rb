module TokyoMetro::CommonModules::Dictionary::RailwayLine::RegexpInfo

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

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