module FareHelper

  # 運賃表全体（全路線の駅への運賃）
  def fare_tables
    stations_of_this_instance = @station.stations_including_other_railway_lines
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
  - ::RailwayLine.tokyo_metro( including_branch_line: true ).each do | railway_line |
    = railway_line.decorate.render_fare_table( stations_of_this_instance , starting_station , fares , normal_fare_groups )
    HAML
  end

  private

  def fare_table_make_rows( fares , stations , normal_fare_groups , make_empty_row_when_no_station: false )
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
    - normal_fare = normal_fare_groups.find( normal_fare_group_id ).decorate
    - stations.each.with_index(1) do | station , i |
      - case i
      - when number_of_stations_in_this_group
        %tr{ class: :last }<
          = station.decorate.render_in_fare_table
          - if i == 1
            = normal_fare.render_columns( number_of_stations_in_this_group )
      - else
        %tr<
          = station.decorate.render_in_fare_table
          - if i == 1
            = normal_fare.render_columns( number_of_stations_in_this_group )
  - else
    - # normal_fare_group_id が定義されている場合
    - # （運賃が設定されていない場合）
    - stations.each do | station , i |
      %tr<
        = station.decorate.render_in_fare_table
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

end