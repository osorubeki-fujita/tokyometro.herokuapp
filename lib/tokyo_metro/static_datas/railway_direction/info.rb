# 方面の情報を扱うクラス
class TokyoMetro::StaticDatas::RailwayDirection::Info

  include TokyoMetro::ClassNameLibrary::StaticDatas::RailwayDirection

  def initialize( same_as , in_api_same_as , railway_line , station )
    raise "Error" unless /\Aodpt.Station:/ === station
    @same_as = same_as
    @in_api_same_as = in_api_same_as
    @railway_line = railway_line
    @station = station
  end

  attr_reader :same_as , :in_api_same_as , :railway_line , :station

  def self.generate_from_hash( same_as , value )
    self.new( same_as , *( value.values ) )
  end

  def seed
    railway_line_in_db = ::RailwayLine.find_by( same_as: @railway_line )
    station_in_db = ::Station.find_by( same_as: @station )

    if railway_line_in_db.nil?
      railway_line_in_db = ::RailwayLine.find_by( same_as: "Undefined" )
    end
    if station_in_db.nil?
      station_in_db = ::Station.find_by( same_as: "Undefined" )
    end

    ::RailwayDirection.create(
      same_as: @same_as ,
      in_api_same_as: @in_api_same_as ,
      railway_line_id: railway_line_in_db.id ,
      station_id: station_in_db.id
    )
  end

end