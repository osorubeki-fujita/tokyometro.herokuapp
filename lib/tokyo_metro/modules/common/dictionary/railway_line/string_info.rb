# 路線名の名称を定数・モジュール関数として提供する名前空間
# @example
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.ginza_in_system                   => Ginza
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.ginza_same_as                     => odpt.Railway:TokyoMetro.Ginza
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.ginza                             => odpt.Railway:TokyoMetro.Ginza
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.marunouchi_in_system              => Marunouchi
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.marunouchi_same_as                => odpt.Railway:TokyoMetro.Marunouchi
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.marunouchi                        => odpt.Railway:TokyoMetro.Marunouchi
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.marunouchi_branch_in_system       => MarunouchiBranch
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.marunouchi_branch_same_as         => odpt.Railway:TokyoMetro.MarunouchiBra
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.marunouchi_branch                 => odpt.Railway:TokyoMetro.MarunouchiBra
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.hibiya_in_system                  => Hibiya
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.hibiya_same_as                    => odpt.Railway:TokyoMetro.Hibiya
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.hibiya                            => odpt.Railway:TokyoMetro.Hibiya
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.tozai_in_system                   => Tozai
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.tozai_same_as                     => odpt.Railway:TokyoMetro.Tozai
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.tozai                             => odpt.Railway:TokyoMetro.Tozai
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.chiyoda_in_system                 => Chiyoda
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.chiyoda_same_as                   => odpt.Railway:TokyoMetro.Chiyoda
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.chiyoda                           => odpt.Railway:TokyoMetro.Chiyoda
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.chiyoda_branch_in_system          => ChiyodaBranch
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.chiyoda_branch_same_as            => odpt.Railway:TokyoMetro.ChiyodaBranch
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.chiyoda_branch                    => odpt.Railway:TokyoMetro.ChiyodaBranch
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.yurakucho_in_system               => Yurakucho
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.yurakucho_same_as                 => odpt.Railway:TokyoMetro.Yurakucho
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.yurakucho                         => odpt.Railway:TokyoMetro.Yurakucho
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.hanzomon_in_system                => Hanzomon
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.hanzomon_same_as                  => odpt.Railway:TokyoMetro.Hanzomon
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.hanzomon                          => odpt.Railway:TokyoMetro.Hanzomon
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.namboku_in_system                 => Namboku
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.namboku_same_as                   => odpt.Railway:TokyoMetro.Namboku
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.namboku                           => odpt.Railway:TokyoMetro.Namboku
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.fukutoshin_in_system              => Fukutoshin
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.fukutoshin_same_as                => odpt.Railway:TokyoMetro.Fukutoshin
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.fukutoshin                        => odpt.Railway:TokyoMetro.Fukutoshin
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.toei_mita_same_as                 => odpt.Railway:Toei.Mita
#   TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo.toei_mita                         => odpt.Railway:Toei.Mita
module TokyoMetro::Modules::Common::Dictionary::RailwayLine::StringInfo

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/railway_line/tokyo_metro_lines_in_system.yaml" ).each do | item |
    const_name_base = item.underscore.upcase
    const_set( eval( ":#{ const_name_base }_IN_SYSTEM" ) , item )
    const_set( eval( ":#{ const_name_base }_SAME_AS" ) , "odpt.Railway:TokyoMetro.#{ item }" )
    const_set( eval( ":#{ const_name_base }" ) , "odpt.Railway:TokyoMetro.#{ item }" )
  end

  TOEI_MITA_SAME_AS = "odpt.Railway:Toei.Mita"
  TOEI_MITA = TOEI_MITA_SAME_AS

  def self.method_missing( method_name , *args )
    if /_line\Z/ === method_name.to_s
      send( method_name.to_s.gsub( /_line\Z/ , "" ).intern , *args )
    else
      super( method_name , *args )
    end
  end

end