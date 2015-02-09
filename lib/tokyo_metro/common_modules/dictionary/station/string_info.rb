# 駅名を定数・モジュール関数として提供する名前空間
# @example
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.honancho                              => odpt.Station:TokyoMetro.MarunouchiBranch.Honancho
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.nakano_fujimicho                      => odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.nakano_shimbashi                      => odpt.Station:TokyoMetro.MarunouchiBranch.NakanoShimbashi
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.nakano_sakaue_on_marunouchi_line      => odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.nakano_sakaue_on_marunouchi_branch_line => odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.ogikubo                               => odpt.Station:TokyoMetro.Marunouchi.Ogikubo
#
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.honancho_invalid                      => odpt.Station:TokyoMetro.Marunouchi.Honancho
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.nakano_fujimicho_invalid              => odpt.Station:TokyoMetro.Marunouchi.NakanoFujimicho
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.nakano_shimbashi_invalid              => odpt.Station:TokyoMetro.Marunouchi.NakanoShimbashi
#
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.mitaka                                => odpt.Station:JR-East.ChuoTozai.Mitaka
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.tsudanuma                             => odpt.Station:JR-East.SobuTozai.Tsudanuma
#
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.yoyogi_uehara                         => odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.ayase_on_chiyoda_main_line            => odpt.Station:TokyoMetro.Chiyoda.Ayase
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.ayase_on_chiyoda_branch_line          => odpt.Station:TokyoMetro.ChiyodaBranch.Ayase
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.kita_ayase_on_chiyoda_branch_line     => odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.kita_ayase_on_chiyoda_main_line       => odpt.Station:TokyoMetro.Chiyoda.KitaAyase
#
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.shirokane_takanawa                    => odpt.Station:TokyoMetro.Namboku.ShirokaneTakanawa
#
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.wakoshi_on_yurakucho_line             => odpt.Station:TokyoMetro.Yurakucho.Wakoshi
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.wakoshi_on_fukutoshin_line            => odpt.Station:TokyoMetro.Fukutoshin.Wakoshi
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.kotake_mukaihara_on_yurakucho_line    => odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.kotake_mukaihara_on_fukutoshin_line   => odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.ikebukuro_on_yurakucho_line           => odpt.Station:TokyoMetro.Yurakucho.Ikebukuro
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.ikebukuro_on_fukutoshin_line          => odpt.Station:TokyoMetro.Fukutoshin.Ikebukuro
#   TokyoMetro::CommonModules::Dictionary::Station::StringInfo.motomachi_chukagai                    => odpt:Station.YokohamaMinatomiraiRailway.Minatomirai.MotomachiChukagai
module TokyoMetro::CommonModules::Dictionary::Station::StringInfo

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/station/frequently_appeared.yaml" ).each do | const_name , v |
    const_set( eval( ":#{ const_name.upcase }" ) , v )
  end

end