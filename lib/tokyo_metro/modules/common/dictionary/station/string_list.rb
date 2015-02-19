# 駅名のリストを定数・モジュール関数として提供する名前空間
module TokyoMetro::Modules::Common::Dictionary::Station::StringList

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  # 丸ノ内線・丸ノ内支線の駅名リストをセットするためのモジュール関数
  def self.stations_same_as_in_marunouchi_main_and_branch_lines( station_names )
    stations_same_as_in_railway_lines(
      ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.marunouchi_main_and_branch_line_in_system ,
      station_names
    )
  end

  # 有楽町線・副都心線の駅名リストをセットするためのモジュール関数
  def self.stations_same_as_in_yurakucho_and_fukutoshin_lines( station_names )
    stations_same_as_in_railway_lines(
      ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringList.yurakucho_and_fukutoshin_line_in_system ,
      station_names
    )
  end

  # 南北線・都営三田線の駅名リストをセットするためのモジュール関数
  def self.stations_same_as_in_namboku_and_toei_mita_lines( station_names )
    stations_same_as_in_railway_lines(
      [ "odpt.Station:TokyoMetro.Namboku" , "odpt.Station:Toei.Mita" ] ,
      station_names
    )
  end

  def self.stations_same_as_in_railway_lines( railway_lines_in_system , station_names )
    railway_lines_in_system.map { | railway_line |
      if station_names.instance_of?( ::Array )
        station_names.map { | station_name | "odpt.Station:TokyoMetro.#{railway_line}.#{station_name}" }
      elsif station_names.instance_of?( ::String )
        station_name = station_names
        "odpt.Station:TokyoMetro.#{railway_line}.#{station_name}"
      else
        raise "Error"
      end
    }.flatten
  end

  # @!group 丸ノ内支線の駅 (1) - 中野坂上

  # 丸ノ内支線の駅（中野坂上）【駅名部分のみ】
  # @return [String]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.nakano_sakaue_in_system => "NakanoSakaue"
  NAKANO_SAKAUE_IN_SYSTEM = "NakanoSakaue"

  # 丸ノ内支線の駅（中野坂上）
  # @return [String]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.nakano_sakaue => [
  #     "odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue"
  #   ]
  NAKANO_SAKAUE = stations_same_as_in_marunouchi_main_and_branch_lines(
    NAKANO_SAKAUE_IN_SYSTEM
  )

  # @!group 丸ノ内支線の駅 (2) - 方南町、中野富士見町、中野新橋

  # 丸ノ内支線の駅（方南町、中野富士見町、中野新橋）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_shimbashi_in_system => [
  #     "Honancho",
  #     "NakanoFujimicho",
  #     "NakanoShimbashi"
  #   ]
  BETWEEN_HONANCHO_AND_NAKANO_SHIMBASHI_IN_SYSTEM = %W( Honancho NakanoFujimicho NakanoShimbashi )

  # 丸ノ内支線の駅（方南町、中野富士見町、中野新橋）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_shimbashi_including_invalid => [
  #     "odpt.Station:TokyoMetro.Marunouchi.Honancho",
  #     "odpt.Station:TokyoMetro.Marunouchi.NakanoFujimicho",
  #     "odpt.Station:TokyoMetro.Marunouchi.NakanoShimbashi",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.Honancho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoShimbashi"
  #   ]
  BETWEEN_HONANCHO_AND_NAKANO_SHIMBASHI_INCLUDING_INVALID = stations_same_as_in_marunouchi_main_and_branch_lines(
    BETWEEN_HONANCHO_AND_NAKANO_SHIMBASHI_IN_SYSTEM
  )

  # 丸ノ内支線の駅（方南町、中野富士見町、中野新橋）
  # @return [::Array <String>]
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_shimbashi => [
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.Honancho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoShimbashi"
  #   ]
  BETWEEN_HONANCHO_AND_NAKANO_SHIMBASHI = stations_same_as_in_railway_lines(
    [ "MarunouchiBranch" ] , BETWEEN_HONANCHO_AND_NAKANO_SHIMBASHI_IN_SYSTEM
  )

  # @!group 丸ノ内支線の駅 (3) - 方南町、中野富士見町、中野新橋、中野坂上

  # 丸ノ内支線の駅（方南町、中野富士見町、中野新橋、中野坂上）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_sakaue_in_system => [
  #     "Honancho",
  #     "NakanoFujimicho",
  #     "NakanoShimbashi",
  #     "NakanoSakaue"
  #   ]
  BETWEEN_HONANCHO_AND_NAKANO_SAKAUE_IN_SYSTEM = BETWEEN_HONANCHO_AND_NAKANO_SHIMBASHI_IN_SYSTEM + [ NAKANO_SAKAUE_IN_SYSTEM ]

  # 丸ノ内支線の駅（方南町、中野富士見町、中野新橋、中野坂上）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_sakaue_including_invalid => [
  #     "odpt.Station:TokyoMetro.Marunouchi.Honancho",
  #     "odpt.Station:TokyoMetro.Marunouchi.NakanoFujimicho",
  #     "odpt.Station:TokyoMetro.Marunouchi.NakanoShimbashi",
  #     "odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.Honancho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoShimbashi",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue"
  #   ]
  BETWEEN_HONANCHO_AND_NAKANO_SAKAUE_INCLUDING_INVALID = stations_same_as_in_marunouchi_main_and_branch_lines(
    BETWEEN_HONANCHO_AND_NAKANO_SAKAUE_IN_SYSTEM
  )

  # 丸ノ内支線の駅（方南町、中野富士見町、中野新橋、中野坂上）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_sakaue => [
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.Honancho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoShimbashi",
  #     "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue"
  #   ]
  BETWEEN_HONANCHO_AND_NAKANO_SAKAUE = stations_same_as_in_railway_lines(
    [ "MarunouchiBranch" ] , BETWEEN_HONANCHO_AND_NAKANO_SAKAUE_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (1) - 和光市

  # 有楽町線・副都心線 共用区間の駅（和光市）【駅名部分のみ】
  # @return [String]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.wakoshi_in_system => "Wakoshi"
  WAKOSHI_IN_SYSTEM = "Wakoshi"

  # 有楽町線・副都心線 共用区間の駅（和光市）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.wakoshi => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Wakoshi",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi"
  #   ]
  WAKOSHI = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    WAKOSHI_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (2) - 小竹向原

  # 有楽町線・副都心線 共用区間の駅（小竹向原）【駅名部分のみ】
  # @return [String]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.kotake_mukaihara_in_system => "KotakeMukaihara"
  KOTAKE_MUKAIHARA_IN_SYSTEM = "KotakeMukaihara"

  # 有楽町線・副都心線 共用区間の駅（小竹向原）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.kotake_mukaihara => [
  #     "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara"
  #   ]
  KOTAKE_MUKAIHARA = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    KOTAKE_MUKAIHARA_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (3) - 池袋

  # 有楽町線・副都心線 共用区間の駅（池袋）【駅名部分のみ】
  # @return [String]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.ikebukuro_in_system => "Ikebukuro"
  IKEBUKURO_IN_SYSTEM = "Ikebukuro"

  # 有楽町線・副都心線 共用区間の駅（池袋）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.ikebukuro_on_yurakucho_or_fukutoshin_line => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Ikebukuro",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Ikebukuro"
  #   ]
  IKEBUKURO_ON_YURAKUCHO_OR_FUKUTOSHIN_LINE = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    IKEBUKURO_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (3) - 和光市、小竹向原

  # 有楽町線・副都心線 共用区間の駅（和光市、小竹向原）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.wakoshi_and_kotake_mukaihara_in_system => [
  #     "Wakoshi",
  #     "KotakeMukaihara"
  #   ]
  WAKOSHI_AND_KOTAKE_MUKAIHARA_IN_SYSTEM = [ WAKOSHI_IN_SYSTEM , KOTAKE_MUKAIHARA_IN_SYSTEM ]

  # 有楽町線・副都心線 共用区間の駅（和光市、小竹向原）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.wakoshi_and_kotake_mukaihara => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Wakoshi",
  #     "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi",
  #     "odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara"
  #   ]
  WAKOSHI_AND_KOTAKE_MUKAIHARA = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    WAKOSHI_AND_KOTAKE_MUKAIHARA_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (4) - 地下鉄成増、地下鉄赤塚、平和台、氷川台（練板4駅）

  # 有楽町線・副都心線 共用区間の駅（地下鉄成増、地下鉄赤塚、平和台、氷川台）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_chikatetsu_narimasu_and_hikawadai_in_system => [
  #     "ChikatetsuNarimasu",
  #     "ChikatetsuAkatsuka",
  #     "Heiwadai",
  #     "Hikawadai"
  #   ]
  BETWEEN_CHIKATETSU_NARIMASU_AND_HIKAWADAI_IN_SYSTEM = %W( ChikatetsuNarimasu ChikatetsuAkatsuka Heiwadai Hikawadai )

  # 有楽町線・副都心線 共用区間の駅（地下鉄成増、地下鉄赤塚、平和台、氷川台）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_chikatetsu_narimasu_and_hikawadai => [
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Yurakucho.Heiwadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.Hikawadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Heiwadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Hikawadai"
  #   ]
  BETWEEN_CHIKATETSU_NARIMASU_AND_HIKAWADAI = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    BETWEEN_CHIKATETSU_NARIMASU_AND_HIKAWADAI_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (5) - 和光市～氷川台

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_hikawadai_in_system => [
  #     "Wakoshi",
  #     "ChikatetsuNarimasu",
  #     "ChikatetsuAkatsuka",
  #     "Heiwadai",
  #     "Hikawadai"
  #   ]
  BETWEEN_WAKOSHI_AND_HIKAWADAI_IN_SYSTEM = [ WAKOSHI_IN_SYSTEM ] + %W( ChikatetsuNarimasu ChikatetsuAkatsuka Heiwadai Hikawadai )

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_hikawadai => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Wakoshi",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Yurakucho.Heiwadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.Hikawadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Heiwadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Hikawadai"
  #   ]
  BETWEEN_WAKOSHI_AND_HIKAWADAI = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    BETWEEN_WAKOSHI_AND_HIKAWADAI_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (6) - 和光市～小竹向原

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台、小竹向原）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_kotake_mukaihara_in_system => [
  #     "Wakoshi",
  #     "ChikatetsuNarimasu",
  #     "ChikatetsuAkatsuka",
  #     "Heiwadai",
  #     "Hikawadai",
  #     "KotakeMukaihara"
  #   ]
  BETWEEN_WAKOSHI_AND_KOTAKE_MUKAIHARA_IN_SYSTEM = BETWEEN_WAKOSHI_AND_HIKAWADAI_IN_SYSTEM + [ KOTAKE_MUKAIHARA_IN_SYSTEM ]

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台、小竹向原）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_kotake_mukaihara => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Wakoshi",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Yurakucho.Heiwadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.Hikawadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Heiwadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Hikawadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara"
  #   ]
  BETWEEN_WAKOSHI_AND_KOTAKE_MUKAIHARA = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    BETWEEN_WAKOSHI_AND_KOTAKE_MUKAIHARA_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (7) - 千川、要町

  # 有楽町線・副都心線 共用区間の駅（千川、要町）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_senkawa_and_kanamecho_in_system => [
  #     "Senkawa",
  #     "Kanamecho"
  #   ]
  BETWEEN_SENKAWA_AND_KANAMECHO_IN_SYSTEM = %W( Senkawa Kanamecho )

  # 有楽町線・副都心線 共用区間の駅（千川、要町）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_senkawa_and_kanamecho => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Senkawa",
  #     "odpt.Station:TokyoMetro.Yurakucho.Kanamecho",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Senkawa",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Kanamecho"
  #   ]
  BETWEEN_SENKAWA_AND_KANAMECHO = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    BETWEEN_SENKAWA_AND_KANAMECHO_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (8) - 和光市～要町

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台、小竹向原、千川、要町）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_kanamecho_in_system => [
  #     "Wakoshi",
  #     "ChikatetsuNarimasu",
  #     "ChikatetsuAkatsuka",
  #     "Heiwadai",
  #     "Hikawadai",
  #     "KotakeMukaihara",
  #     "Senkawa",
  #     "Kanamecho"
  #   ]
  BETWEEN_WAKOSHI_AND_KANAMECHO_IN_SYSTEM = BETWEEN_WAKOSHI_AND_KOTAKE_MUKAIHARA_IN_SYSTEM + BETWEEN_SENKAWA_AND_KANAMECHO_IN_SYSTEM

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台、小竹向原、千川、要町）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_wakoshi_and_kanamecho => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Wakoshi",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Yurakucho.Heiwadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.Hikawadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Yurakucho.Senkawa",
  #     "odpt.Station:TokyoMetro.Yurakucho.Kanamecho",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Heiwadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Hikawadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Senkawa",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Kanamecho"
  #   ]
  BETWEEN_WAKOSHI_AND_KANAMECHO = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    BETWEEN_WAKOSHI_AND_KANAMECHO_IN_SYSTEM
  )

  # @!group 有楽町線・副都心線 共用区間 (9) - 和光市～池袋

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台、小竹向原、千川、要町、池袋）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.yurakucho_and_fukutoshin_common_stations_in_system => [
  #     "Wakoshi",
  #     "ChikatetsuNarimasu",
  #     "ChikatetsuAkatsuka",
  #     "Heiwadai",
  #     "Hikawadai",
  #     "KotakeMukaihara",
  #     "Senkawa",
  #     "Kanamecho",
  #     "Ikebukuro"
  #   ]
  YURAKUCHO_AND_FUKUTOSHIN_COMMON_STATIONS_IN_SYSTEM = BETWEEN_WAKOSHI_AND_KANAMECHO_IN_SYSTEM + [ IKEBUKURO_IN_SYSTEM ]
  BETWEEN_WAKOSHI_AND_IKEBUKURO_IN_SYSTEM = YURAKUCHO_AND_FUKUTOSHIN_COMMON_STATIONS_IN_SYSTEM

  # 有楽町線・副都心線 共用区間の駅（和光市、地下鉄成増、地下鉄赤塚、平和台、氷川台、小竹向原、千川、要町、池袋）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.yurakucho_and_fukutoshin_common_stations => [
  #     "odpt.Station:TokyoMetro.Yurakucho.Wakoshi",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Yurakucho.Heiwadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.Hikawadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Yurakucho.Senkawa",
  #     "odpt.Station:TokyoMetro.Yurakucho.Kanamecho",
  #     "odpt.Station:TokyoMetro.Yurakucho.Ikebukuro",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Heiwadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Hikawadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Senkawa",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Kanamecho",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Ikebukuro",
  #     "odpt.Station:TokyoMetro.Yurakucho.Wakoshi",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Yurakucho.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Yurakucho.Heiwadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.Hikawadai",
  #     "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Yurakucho.Senkawa",
  #     "odpt.Station:TokyoMetro.Yurakucho.Kanamecho",
  #     "odpt.Station:TokyoMetro.Yurakucho.Ikebukuro",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Wakoshi",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuNarimasu",
  #     "odpt.Station:TokyoMetro.Fukutoshin.ChikatetsuAkatsuka",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Heiwadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Hikawadai",
  #     "odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Senkawa",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Kanamecho",
  #     "odpt.Station:TokyoMetro.Fukutoshin.Ikebukuro"
  #   ]
  YURAKUCHO_AND_FUKUTOSHIN_COMMON_STATIONS = stations_same_as_in_yurakucho_and_fukutoshin_lines(
    YURAKUCHO_AND_FUKUTOSHIN_COMMON_STATIONS_IN_SYSTEM
  )
  BETWEEN_WAKOSHI_AND_IKEBUKURO = YURAKUCHO_AND_FUKUTOSHIN_COMMON_STATIONS

  # @!group 南北線・都営三田線 共用区間

  # 南北線・都営三田線 共用区間の駅（目黒、白金台、白金高輪）【駅名部分のみ】
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.namboku_and_toei_mita_line_common_stations_in_system => [
  #     "Meguro",
  #     "Shirokanedai",
  #     "ShirokaneTakanawa"
  #   ]
  NAMBOKU_AND_TOEI_MITA_LINE_COMMON_STATIONS_IN_SYSTEM = %W( Meguro Shirokanedai ShirokaneTakanawa )

  # 南北線・都営三田線 共用区間の駅（目黒、白金台、白金高輪）
  # @return [::Array <String>]
  # @example
  #   TokyoMetro::Modules::Common::Dictionary::Station::StringList.namboku_and_toei_mita_line_common_stations => [
  #     "odpt.Station:TokyoMetro.odpt.Station:TokyoMetro.Namboku.Meguro",
  #     "odpt.Station:TokyoMetro.odpt.Station:TokyoMetro.Namboku.Shirokanedai",
  #     "odpt.Station:TokyoMetro.odpt.Station:TokyoMetro.Namboku.ShirokaneTakanawa",
  #     "odpt.Station:TokyoMetro.odpt.Station:Toei.Mita.Meguro",
  #     "odpt.Station:TokyoMetro.odpt.Station:Toei.Mita.Shirokanedai",
  #     "odpt.Station:TokyoMetro.odpt.Station:Toei.Mita.ShirokaneTakanawa"
  #   ]
  NAMBOKU_AND_TOEI_MITA_LINE_COMMON_STATIONS = stations_same_as_in_namboku_and_toei_mita_lines(
    NAMBOKU_AND_TOEI_MITA_LINE_COMMON_STATIONS_IN_SYSTEM
  )

  # @!endgroup

end