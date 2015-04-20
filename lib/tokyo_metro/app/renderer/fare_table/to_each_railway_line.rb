class TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine < TokyoMetro::App::Renderer::MetaClass

  # @params station_infos_including_other_railway_lines は、駅（全路線）のインスタンスとする。
  # @params railway_line [::RailwayLine]
  def initialize( request , railway_line , station_infos_including_other_railway_lines , starting_station_info , fares , normal_fare_groups )
    super( request )
    @railway_line = railway_line
    @station_infos_including_other_railway_lines = station_infos_including_other_railway_lines
    @starting_station_info = starting_station_info
    @fares = fares
    @normal_fare_groups = normal_fare_groups

    @station_infos_of_railway_line = set_station_infos_of_railway_line
    @id_of_starting_station_info = set_id_of_starting_station_info
  end

  def render
    if @id_of_starting_station_info.present?
      render_when_having_starting_station_info
    else
      render_when_not_having_starting_station_info
    end
  end

  private

  def h_locals
    super.merge({
      station_infos_including_other_railway_lines: @station_infos_including_other_railway_lines ,
      starting_station_info: @starting_station_info ,
      railway_line: @railway_line ,
      fares: @fares ,
      normal_fare_groups: @normal_fare_groups ,
      id_of_starting_station_info: @id_of_starting_station_info
    }).merge( station_infos_of_railway_line_in_h_locals )
  end

  def render_when_having_starting_station_info
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%table{ class: [ :fare_table , railway_line.css_class_name ] }
  = ::FareDecorator.render_header_of_fare_table
  = ::TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::Rows.new( request , station_infos_of_railway_line_before_starting_station , fares , normal_fare_groups , to_make_empty_row_when_no_station: true ).render
  - #
  %tr<
    = ::Station::Info.find( id_of_starting_station_info ).decorate.render_in_fare_table( starting_station_info: true )
    %td{ class: :starting_station , colspan: 4 }<
      %div{ class: :text_ja }
        = "この駅からの運賃を表示しています"
      %div{ class: :text_en }
        = "Fares from this station are displayed now."
  - #
  = ::TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::Rows.new( request , station_infos_of_railway_line_after_starting_station , fares , normal_fare_groups ).render
    HAML
  end

  def render_when_not_having_starting_station_info
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%table{ class: [ :fare_table , railway_line.css_class_name ] }
  = ::FareDecorator.render_header_of_fare_table
  = ::TokyoMetro::App::Renderer::FareTable::ToEachRailwayLine::Rows.new( request , station_infos_of_railway_line , fares , normal_fare_groups ).render
    HAML
  end

  def set_station_infos_of_railway_line
    @railway_line.station_infos.order( :index_in_railway_line )
  end

  # 路線のインスタンス railway_line に、
  # station_infos_including_other_railway_lines の要素である駅（路線別）が含まれている場合は、その駅の id を返す。
  # 含まれていない場合は、nil を返す。
  # @param stations_of_this_instance 駅（路線）のインスタンス
  # @return [Integer or nil]
  # @note
  def set_id_of_starting_station_info
    ids_of_station_infos = @station_infos_including_other_railway_lines.pluck( :id )
    ids_of_this_railway_line = @railway_line.station_infos.pluck( :id )
    common_station_ids = ( ids_of_station_infos & ids_of_this_railway_line )
    if common_station_ids.empty?
      nil
    elsif common_station_ids.length == 1
      common_station_ids.first
    else
      raise "Error"
    end
  end

  def station_infos_of_railway_line_in_h_locals
    if @id_of_starting_station_info.blank?
      { station_infos_of_railway_line: @station_infos_of_railway_line }
    else
      station_infos_of_railway_line_split_by_starting_station
    end

  end

  def station_infos_of_railway_line_split_by_starting_station
    raise "Error" if @id_of_starting_station_info.blank?

    if @station_infos_of_railway_line.first.id == @id_of_starting_station_info
      {
        station_infos_of_railway_line_before_starting_station: nil ,
        station_infos_of_railway_line_after_starting_station: @station_infos_of_railway_line[ 1..(-1) ]
      }

    elsif @station_infos_of_railway_line.last.id == @id_of_starting_station_info
      {
        station_infos_of_railway_line_before_starting_station: @station_infos_of_railway_line[ 0..(-2) ] ,
        station_infos_of_railway_line_after_starting_station: nil
      }

    else
      position_of_starting_station_info = @station_infos_of_railway_line.index { | station_info | station_info.id == @id_of_starting_station_info }
      {
        station_infos_of_railway_line_before_starting_station: @station_infos_of_railway_line[ 0..( position_of_starting_station_info - 1 ) ] ,
        station_infos_of_railway_line_after_starting_station: @station_infos_of_railway_line[ ( position_of_starting_station_info + 1 )..( -1 ) ]
      }
    end
  end

end