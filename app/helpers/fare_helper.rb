module FareHelper

  # 運賃表全体（全路線の駅への運賃）
  def fare_tables
    station_infos_of_this_instance = @station_info.station_infos_including_other_railway_lines
    starting_station_info = station_infos_of_this_instance.first
    fares = ::Fare.where( from_station_info_id: starting_station_info.id ).includes( :from_station_info , :to_station_info , :normal_fare_group )

    h_locals = {
      station_infos_of_this_instance: station_infos_of_this_instance ,
      starting_station_info: starting_station_info ,
      fares: fares ,
      normal_fare_groups: @normal_fare_groups
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :fare_tables }
  - ::RailwayLine.tokyo_metro( including_branch_line: true ).each do | railway_line |
    = railway_line.decorate.render_fare_table( station_infos_of_this_instance , starting_station_info , fares , normal_fare_groups )
    HAML
  end

  private

  def fare_table_make_rows( fares , station_infos , normal_fare_groups , make_empty_row_when_no_station: false )
    if station_infos.present?
      class << station_infos
        include ForRails::FareTable::StationInfosGroupedByFare
      end
      station_infos_grouped_by_fare = station_infos.fare_table_station_infos_grouped_by_fare( fares )
      h_locals = {
        station_infos_grouped_by_fare: station_infos_grouped_by_fare ,
        normal_fare_groups: normal_fare_groups
      }

      render inline: <<-HAML , type: :haml , locals: h_locals
- station_infos_grouped_by_fare.each do | normal_fare_group |
  - normal_fare_group_id = normal_fare_group[ :normal_fare_group_id ]
  - station_infos = normal_fare_group[ :station_infos ]
  - number_of_station_infos_in_this_group = station_infos.length
  - unless normal_fare_group_id == 0
    - # normal_fare_group_id が定義されている場合
    - normal_fare = normal_fare_groups.find( normal_fare_group_id ).decorate
    - station_infos.each.with_index(1) do | station_info , i |
      - case i
      - when number_of_station_infos_in_this_group
        %tr{ class: :last }<
          = station_info.decorate.render_in_fare_table
          - if i == 1
            = normal_fare.render_columns( number_of_station_infos_in_this_group )
      - else
        %tr<
          = station_info.decorate.render_in_fare_table
          - if i == 1
            = normal_fare.render_columns( number_of_station_infos_in_this_group )
  - else
    - # normal_fare_group_id が定義されている場合
    - # （運賃が設定されていない場合）
    - station_infos.each do | station_info , i |
      %tr<
        = station_info.decorate.render_in_fare_table
        %td{ colspan: number_of_station_infos_in_this_group , colspan: 4 , class: :no_fare }<>
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