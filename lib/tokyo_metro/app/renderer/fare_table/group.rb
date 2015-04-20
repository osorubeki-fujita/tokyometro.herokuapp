class TokyoMetro::App::Renderer::FareTable::Group < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , station_info , railway_line_of_terminal_station )
    super( request )
    @normal_fare_groups = ::NormalFareGroup.all
    @station_info = station_info
    @railway_lines_of_terminal_station = [ railway_line_of_terminal_station ].flatten
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :fare_tables }
  - railway_lines_of_terminal_station.each do | railway_line |
    = ::TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine.new( request , railway_line , station_infos_including_other_railway_lines , starting_station_info , fares , normal_fare_groups ).render
    HAML
  end

  private

  def h_locals
    super.merge({
      station_infos_including_other_railway_lines: station_infos_including_other_railway_lines ,
      starting_station_info: starting_station_info ,
      fares: fares ,
      normal_fare_groups: @normal_fare_groups ,
      railway_lines_of_terminal_station: @railway_lines_of_terminal_station
    })
  end

  def station_infos_including_other_railway_lines
    @station_info.station_infos_including_other_railway_lines
  end

  def starting_station_info
    station_infos_including_other_railway_lines.first
  end

  def to_station_ids
    @railway_lines_of_terminal_station.map( &:station_infos ).flatten.map( &:id ).sort.uniq
  end

  def fares
    ::Fare.where( from_station_info_id: starting_station_info.id , to_station_info_id: to_station_ids ).includes(
      :from_station_info ,
      :to_station_info ,
      :normal_fare_group
    )
  end

end