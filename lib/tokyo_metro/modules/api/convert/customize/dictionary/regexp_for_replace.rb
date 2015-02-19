module TokyoMetro::Modules::Api::Convert::Customize::Dictionary::RegexpForReplace

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  MARUNOUCHI_BRANCH_LINE_STATIONS = /(?<=\Aodpt\.Station\:TokyoMetro\.)Marunouchi(?:Branch)?(?=\.(?:Honancho|Nakano(?:Fujimicho|Shimbashi)))/
  NAKANO_SAKAUE = /(?<=\Aodpt\.Station\:TokyoMetro\.)Marunouchi(?:Branch)?(?=\.NakanoSakaue)/
  CHIYODA_BRANCH_LINE_STATIONS = /(?<=\Aodpt\.Station\:TokyoMetro\.)Chiyoda(?:Branch)?(?=\.(?:Kita)?Ayase\Z)/
  NAMBOKU_AND_TOEI_MITA_LINE_COMMON_STATIONS = /(?<=\Aodpt\.Station\:)(?:TokyoMetro\.Namboku|Toei\.Mita)(?=\.(?:Meguro|Shirokane(?:dai|Takanawa)))/

end