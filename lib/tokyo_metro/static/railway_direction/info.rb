# 方面の情報を扱うクラス
class TokyoMetro::Static::RailwayDirection::Info

  include ::TokyoMetro::ClassNameLibrary::Static::RailwayDirection
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  def initialize( same_as , in_api_same_as , railway_line , railway_direction_code , station )
    raise "Error" unless /\Aodpt.Station:/ === station
    @same_as = same_as
    @in_api_same_as = in_api_same_as
    @railway_line = railway_line
    @railway_direction_code = railway_direction_code
    @station = station
  end

  attr_reader :same_as , :in_api_same_as , :railway_line , :railway_direction_code , :station

end