# 駅名を定数・モジュール関数として提供する名前空間
# @example
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.honancho                              => odpt.Station:TokyoMetro.MarunouchiBranch.Honancho
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.nakano_fujimicho                      => odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.nakano_shimbashi                      => odpt.Station:TokyoMetro.MarunouchiBranch.NakanoShimbashi
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.nakano_sakaue_on_marunouchi_line      => odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.nakano_sakaue_on_marunouchi_branch_line => odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.ogikubo                               => odpt.Station:TokyoMetro.Marunouchi.Ogikubo
#
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.honancho_invalid                      => odpt.Station:TokyoMetro.Marunouchi.Honancho
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.nakano_fujimicho_invalid              => odpt.Station:TokyoMetro.Marunouchi.NakanoFujimicho
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.nakano_shimbashi_invalid              => odpt.Station:TokyoMetro.Marunouchi.NakanoShimbashi
#
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.mitaka                                => odpt.Station:JR-East.ChuoTozai.Mitaka
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.tsudanuma                             => odpt.Station:JR-East.SobuTozai.Tsudanuma
#
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.yoyogi_uehara                         => odpt.Station:TokyoMetro.Chiyoda.YoyogiUehara
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.ayase_on_chiyoda_main_line            => odpt.Station:TokyoMetro.Chiyoda.Ayase
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.ayase_on_chiyoda_branch_line          => odpt.Station:TokyoMetro.ChiyodaBranch.Ayase
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.kita_ayase_on_chiyoda_branch_line     => odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.kita_ayase_on_chiyoda_main_line       => odpt.Station:TokyoMetro.Chiyoda.KitaAyase
#
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.shirokane_takanawa                    => odpt.Station:TokyoMetro.Namboku.ShirokaneTakanawa
#
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.wakoshi_on_yurakucho_line             => odpt.Station:TokyoMetro.Yurakucho.Wakoshi
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.wakoshi_on_fukutoshin_line            => odpt.Station:TokyoMetro.Fukutoshin.Wakoshi
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.kotake_mukaihara_on_yurakucho_line    => odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.kotake_mukaihara_on_fukutoshin_line   => odpt.Station:TokyoMetro.Fukutoshin.KotakeMukaihara
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.ikebukuro_on_yurakucho_line           => odpt.Station:TokyoMetro.Yurakucho.Ikebukuro
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.ikebukuro_on_fukutoshin_line          => odpt.Station:TokyoMetro.Fukutoshin.Ikebukuro
#   TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.motomachi_chukagai                    => odpt:Station.YokohamaMinatomiraiRailway.Minatomirai.MotomachiChukagai
module TokyoMetro::Modules::Common::Dictionary::Station::StringInfo

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/station/frequently_appeared.yaml" ).each do | const_name , v |
    const_set( eval( ":#{ const_name.upcase }" ) , v )
  end

end