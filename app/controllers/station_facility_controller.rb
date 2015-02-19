class StationFacilityController < ApplicationController

  include EachRailwayLine
  include YurakuchoAndFukutoshinLine

  include EachStation

  def index
    @title = "駅のご案内"
    @railway_lines = RailwayLine.tokyo_metro
    @stations_of_railway_lines = ::Station.tokyo_metro
    @tokyo_metro_station_dictionary = ::TokyoMetro.station_dictionary
    @tokyo_metro_station_dictionary_including_main_info = ::TokyoMetro.station_dictionary_including_main_info( @stations_of_railway_lines )

    render 'station_facility/index'
  end

  private

  def each_railway_line( *railway_line_name_codes )
    each_railway_line_sub( "駅のご案内" , "station_facility" , *railway_line_name_codes , with_branch: true , layout: "application_wide" )
  end

  def each_station( station_name )
    each_station_sub( "駅のご案内" , "station_facility" , station_name , layout: "application_wide" ) do
      @display_google_map = true
      @station_facility = @station.station_facility

      @points = @station_facility.points.includes( :point_category )

      set_platform_info_tab
      set_station_info_for_google_map
      set_exit_info_for_google_map
    end
  end

  def set_platform_info_tab
    if %w( Wakoshi ChikatetsuNarimasu ChikatetsuAkatsuka Heiwadai Hikawadai KotakeMukaihara ).include?( @station.name_in_system )
      @default_platform_info_tab = :platform_info_yurakucho_and_fukutoshin_line
      @platform_info_tabs = [ @default_platform_info_tab ]
    elsif %w( Meguro Shirokanedai ShirokaneTakanawa ).include?( @station.name_in_system )
      @default_platform_info_tab = :platform_info_namboku_and_toei_mita_line
      @platform_info_tabs = [ @default_platform_info_tab ]
    else
      railway_lines = @station_facility.stations.map { | station | station.railway_line }.sort_by { | railway_line | railway_line.id }
      @platform_info_tabs =railway_lines.map { | railway_line | railway_line.css_class_name  }
      @default_platform_info_tab = @platform_info_tabs.first
    end
  end

  def set_station_info_for_google_map
    @station_info_for_google_map = Gmaps4rails.build_markers( @station_facility.stations ) do | station , marker |
      marker.lat( station.latitude )
      marker.lng( station.longitude )
      marker.infowindow( "#{station.name_ja}（#{station.railway_line.name_ja}）" )
      marker.json( { title: station.name_ja } )
    end
  end

  def set_exit_info_for_google_map
    @exit_info_for_google_map = Gmaps4rails.build_markers( @points ) do | point , marker |
      info_window_ja = String.new
      info_window_en = String.new
      if point.closed
        info_window_ja << "【現在閉鎖中】"
        info_window_en << "【Closed】"
      end
      info_window_ja << "#{point.point_category.name_ja} #{point.code}"
      info_window_en << "(Exit #{point.code})"
      if point.elevator.present?
        info_window_ja << "（エレベーターあり）"
        info_window_en << " (With an elevator)"
      end
      if point.additional_info.present?
        info_window_ja << "（#{point.additional_info}）"
      end

      marker.lat( point.latitude )
      marker.lng( point.longitude )
      marker.infowindow( [ info_window_ja , info_window_en ].join( " " ) )
      json_title = @station.name_ja  + " " + @station.name_en
      marker.json( { title: json_title } )
    end
  end

end