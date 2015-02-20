module StationLinkMatrixHelper

  def station_link_matrix_and_lists( make_link_to_line: false )
    render inline: <<-HAML , type: :haml , locals: { make_link_to_line: make_link_to_line }
= station_link_matrix( make_link_to_line )
= station_link_list_ja
= station_link_list_en
    HAML
  end

  private

  # 駅一覧表（路線別）を作成
  def station_link_matrix( make_link_to_line )
    h_locals = {
      railway_lines: @railway_lines ,
      stations_of_railway_lines: @stations_of_railway_lines ,
      tokyo_metro_station_dictionary: @tokyo_metro_station_dictionary ,
      tokyo_metro_station_dictionary_including_main_info: @tokyo_metro_station_dictionary_including_main_info ,
      make_link_to_line: make_link_to_line
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :station_matrixes }
  - railway_lines.each do | railway_line |
    %div{ class: :railway_line }
      = railway_line.decorate.render_matrix( make_link_to_line: make_link_to_line , size: :small )
      %div{ class: :stations }
        - if railway_line.same_as == "odpt.Railway:TokyoMetro.Marunouchi"
          = station_link_matrix_of_marunouchi_line( railway_line , stations_of_railway_lines , tokyo_metro_station_dictionary , tokyo_metro_station_dictionary_including_main_info )
        - else
          = station_link_matrix_of_normal_railway_line( railway_line.stations , stations_of_railway_lines , tokyo_metro_station_dictionary , tokyo_metro_station_dictionary_including_main_info )
    HAML
  end

  # 通常の路線の駅一覧を書き出す
  def station_link_matrix_of_normal_railway_line(
    stations ,
    stations_of_railway_lines ,
    tokyo_metro_station_dictionary ,
    tokyo_metro_station_dictionary_including_main_info
  )
    h_locals = {
      stations: stations.sort_by( &:index_in_railway_line ) ,
      stations_of_railway_lines: stations_of_railway_lines ,
      tokyo_metro_station_dictionary: tokyo_metro_station_dictionary ,
      tokyo_metro_station_dictionary_including_main_info: tokyo_metro_station_dictionary_including_main_info
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
- stations.each do | station |
  %div{ class: :station }<
    - station_hash = tokyo_metro_station_dictionary_including_main_info[ station.name_in_system ]
    = station_link_proc_ja.call( station_hash , tokyo_metro_station_dictionary )
    HAML
  end

  # 丸ノ内線（支線を含む）の駅一覧を書き出す
  def station_link_matrix_of_marunouchi_line(
    railway_line ,
    stations_of_railway_lines ,
    tokyo_metro_station_dictionary ,
    tokyo_metro_station_dictionary_including_main_info
  )
    h_locals = {
      railway_line: railway_line ,
      stations_of_railway_lines: stations_of_railway_lines ,
      branch_stations: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" ).stations ,
      tokyo_metro_station_dictionary: tokyo_metro_station_dictionary ,
      tokyo_metro_station_dictionary_including_main_info: tokyo_metro_station_dictionary_including_main_info
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :main_line }
  = station_link_matrix_of_normal_railway_line( railway_line.stations , tokyo_metro_station_dictionary , stations_of_railway_lines , tokyo_metro_station_dictionary_including_main_info )
%div{ class: :branch_line }
  = station_link_matrix_of_normal_railway_line( branch_stations , tokyo_metro_station_dictionary , stations_of_railway_lines , tokyo_metro_station_dictionary_including_main_info )
    HAML
  end

end