class TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::Rows < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , station_infos , fares , normal_fare_groups , to_make_empty_row_when_no_station: false )
    super( request )
    @station_infos = station_infos
    @fares = fares
    @normal_fare_groups = normal_fare_groups
    @to_make_empty_row_when_no_station = to_make_empty_row_when_no_station
  end

  def render
    if @station_infos.blank? and @to_make_empty_row_when_no_station
      render_empty_row_when_no_station
    elsif @station_infos.present?
      render_normal_rows
    end
  end

  private

  def render_empty_row_when_no_station
    h.render inline: <<-HAML , type: :haml
%tr{ class: :empty_row }<
  %td{ colspan:5 }<
    HAML
  end

  def render_normal_rows
    ::TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::StationInfos.make_group_from( request , @station_infos , @fares , @normal_fare_groups ).render
  end

  def h_locals
    super.merge({
      # station_infos: @station_infos ,
      # fares: @fares ,
      normal_fare_groups: @normal_fare_groups ,
      station_infos_grouped_by_fare: station_infos_grouped_by_fare
    })
  end

end