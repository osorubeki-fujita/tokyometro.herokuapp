module FareTableHelper

  # 運賃表全体（全路線の駅への運賃）
  def fare_tables
    stations_of_this_instance = @station.stations_of_tokyo_metro
    starting_station = stations_of_this_instance.first
    fares = ::Fare.where( from_station_id: starting_station.id ).includes( :from_station , :to_station , :normal_fare_group )

    h_locals = {
      stations_of_this_instance: stations_of_this_instance ,
      starting_station: starting_station ,
      fares: fares ,
      normal_fare_groups: @normal_fare_groups
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :fare_tables }
  - ::RailwayLine.tokyo_metro_including_branch.where.not( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" ).each do | railway_line |
    = fare_table_of_each_railway_line( railway_line , stations_of_this_instance , starting_station , fares , normal_fare_groups )
    HAML
  end

  private

  # 各路線のすべての駅への運賃
  # @param railway_line [RailwayLine] 路線のインスタンス
  # @param stations_of_this_instance [Array <Station>] 駅（複数、同名）のインスタンスのリスト（複数路線がある場合は、各路線のインスタンスを保持）
  # @param starting_station [Station] 運賃表の基準駅のインスタンス
  def fare_table_of_each_railway_line( railway_line , stations_of_this_instance , starting_station , fares , normal_fare_groups )

    # 路線のインスタンス railway_line に、
    # stations_of_this_instance の要素である駅（路線別）が含まれている場合は、その駅の id を返す。
    # 含まれていない場合は、nil
    class << railway_line
      include ForRails::FareTable::StartingStationIdIncludedInThisRailwayLine
    end

    id_of_starting_station_id_included_in_this_railway_line = railway_line.fare_table_starting_station_id_included_in_this_railway_line( stations_of_this_instance )

    h_locals = {
      railway_line: railway_line ,
      stations_of_this_instance: stations_of_this_instance ,
      id_of_starting_station_id_included_in_this_railway_line: id_of_starting_station_id_included_in_this_railway_line ,
      starting_station: starting_station ,
      fares: fares ,
      normal_fare_groups: normal_fare_groups
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%table{ class: [ :fare_table , railway_line.css_class_name ] }
  - # ヘッダーの作成
  = fare_table_header
  - stations_in_this_railway_line = railway_line.stations.order( :index_in_railway_line )
  - # 路線のインスタンス railway_line に stations_of_this_instance の要素である駅（路線別）が含まれている場合
  - if id_of_starting_station_id_included_in_this_railway_line.present?
    - class << stations_in_this_railway_line
      - include ForRails::FareTable::SplitStationsByStartingStationId
    - group_of_stations = stations_in_this_railway_line.fare_table_split_stations_by_starting_station_id( id_of_starting_station_id_included_in_this_railway_line )
    - before_starting_station = group_of_stations[0]
    - after_starting_station = group_of_stations[1]
    - #
    - if starting_station.nil?
      - err_msg = "Error: Station.find( " + id_of_starting_station_id_included_in_this_railway_line.to_s + " ) is not valid."
    - #
    = fare_table_make_rows( starting_station , before_starting_station , fares , normal_fare_groups , make_empty_row_when_no_station: true )
    = fare_table_make_row_of_this_station( stations_of_this_instance , railway_line )
    = fare_table_make_rows( starting_station , after_starting_station , fares , normal_fare_groups )
    - #
    - # 路線のインスタンス railway_line に stations_of_this_instance の要素である駅（路線別）が含まれていない場合
  - else
    = fare_table_make_rows( starting_station , stations_in_this_railway_line , fares , normal_fare_groups )
    HAML
  end

  def fare_table_make_rows( starting_station , stations , fares , normal_fare_groups , make_empty_row_when_no_station: false )
    if stations.present?
      class << stations
        include ForRails::FareTable::StationsGroupedByFare
      end
      stations_grouped_by_fare = stations.fare_table_stations_grouped_by_fare( fares )
      h_locals = {
        stations_grouped_by_fare: stations_grouped_by_fare ,
        normal_fare_groups: normal_fare_groups
      }

      render inline: <<-HAML , type: :haml , locals: h_locals
- stations_grouped_by_fare.each do | normal_fare_group |
  - normal_fare_group_id = normal_fare_group[ :normal_fare_group_id ]
  - stations = normal_fare_group[ :stations ]
  - number_of_stations_in_this_group = stations.length
  - unless normal_fare_group_id == 0
    - # normal_fare_group_id が定義されている場合
    - normal_fare = normal_fare_groups.find( normal_fare_group_id )
    - stations.each.with_index(1) do | station , i |
      - if i == number_of_stations_in_this_group
        %tr{ class: :last }<
          = fare_table_station_name( station )
          - if i == 1
            = fare_table_columns( number_of_stations_in_this_group , normal_fare )
      - else
        %tr<
          = fare_table_station_name( station )
          - if i == 1
            = fare_table_columns( number_of_stations_in_this_group , normal_fare )
  - else
    - # normal_fare_group_id が定義されている場合
    - # （運賃が設定されていない場合）
    - stations.each do | station , i |
      %tr<
        = fare_table_station_name( station )
        %td{ colspan: number_of_stations_in_this_group , colspan: 4 , class: :no_fare }<>
          = " "
      HAML
    elsif make_empty_row_when_no_station
      render inline: <<-HAML , type: :haml
%tr{ class: :empty_row }<
  %td{ colspan:5 }<
      HAML
    end
  end

  def fare_table_make_row_of_this_station( stations_of_this_instance , railway_line )
    starting_station = stations_of_this_instance.find_by( railway_line_id: railway_line.id )
    raise "Error" if starting_station.nil?
    h_locals = { starting_station: starting_station }
    render inline: <<-HAML , type: :haml , locals: h_locals
%tr<
  = fare_table_station_name( starting_station , starting_station: true )
  %td{ class: :starting_station , colspan: 4 }<
    %div{ class: :text_ja }
      = "この駅からの運賃を表示しています"
    %div{ class: :text_en }
      = "Fares from this station are displayed now."
    HAML
  end

  def fare_table_station_name( station , starting_station: false )
    render inline: <<-HAML , type: :haml , locals: { station: station , starting_station: starting_station }
- if starting_station
  %td{ class: [ :station_name , :starting_station ] }<
    = fare_table_station_name_sub_without_link( station )
- else
  = fare_table_station_name_sub_with_link( station , linked_page: linked_page = station.name_in_system.underscore )
    HAML
  end

  def fare_table_station_name_sub_with_link( station , linked_page: nil )
    h_locals = {
      station: station ,
      linked_page: linked_page
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: :station_name , "data-href" => linked_page }<
  %div{ class: :station_name_domain }
    - if linked_page.present?
      = link_to( "" , linked_page )
    = fare_table_station_name_sub_without_link( station )
    HAML
  end

  def fare_table_station_name_sub_without_link( station )
    render inline: <<-HAML , type: :haml , locals: { station: station }
%div{ class: :station_code_outer }
  = display_images_of_station_codes( station , false )
%div{ class: :station_name_text }
  %div{ class: :text_ja }
    = station_name_ja_processing_subname( station.name_ja )
  %div{ class: :text_en }
    = station_name_en_processing_subname( station.name_en )
    HAML
  end

  def fare_table_columns( number_of_stations_in_this_group , normal_fare )
    h_locals = {
      number_of_stations_in_this_group: number_of_stations_in_this_group ,
      normal_fare: normal_fare
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%td{ rowspan: number_of_stations_in_this_group , class: "ic_card" + "_" + normal_fare.id.to_s }<>
  = number_separated_by_comma( normal_fare.ic_card_fare )
%td{ rowspan: number_of_stations_in_this_group , class: "ic_card" + "_" + normal_fare.id.to_s }<>
  = number_separated_by_comma( normal_fare.child_ic_card_fare )
%td{ rowspan: number_of_stations_in_this_group , class: "ticket" + "_" + normal_fare.id.to_s }<>
  = number_separated_by_comma( normal_fare.ticket_fare )
%td{ rowspan: number_of_stations_in_this_group , class: "ticket" + "_" + normal_fare.id.to_s }<>
  = number_separated_by_comma( normal_fare.child_ticket_fare )
    HAML
  end

end