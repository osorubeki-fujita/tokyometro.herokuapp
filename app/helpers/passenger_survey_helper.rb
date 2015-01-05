#! ruby -Ku
# -*- coding: utf-8 -*-

module PassengerSurveyHelper

  # Top の title を記述するメソッド
  def passenger_survey_title_in_top
    render inline: <<-HAML , type: :haml
%div{ id: :passenger_survey_title }
  = passenger_survey_common_title
  = application_common_top_title
    HAML
  end

  # タイトルを記述するメソッド（路線別）
  def passenger_survey_title_of_grouped_by_line
    render inline: <<-HAML , type: :haml , locals: { railway_lines: @railway_lines }
%div{ id: :passenger_survey_title }
  = passenger_survey_common_title( :railway_line )
  = railway_line_name_main( railway_lines )
    HAML
  end

  # タイトルを記述するメソッド（年度別）
  def passenger_survey_title_grouped_by_year
    render inline: <<-HAML , type: :haml , locals: { year: @year }
%div{ id: :passenger_survey_title }
  = passenger_survey_common_title( :year )
  = passenger_survey_year_in_title( year )
    HAML
  end

  def passenger_survey_title_of_each_station
    render inline: <<-HAML , type: :haml , locals: { station: @station }
%div{ id: :passenger_survey_title }
  = passenger_survey_common_title( :station )
  = station_name_main( @station , station_code: true , all_station_codes: true )
    HAML
  end

  # Table を作成するメソッド
  def passenger_survey_table
    case @type
    when :year
      class_name = :tokyo_metro
    when :railway_line
      class_name = @railway_lines_including_branch.first.css_class_name
    when :station
      class_name = :station
    end

    h_locals ={
      list_of_passenger_surveys: @list_of_passenger_surveys ,
      type: @type ,
      make_graph: @make_graph ,
      class_name: class_name
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :passenger_survey_table , class: class_name }
  %table{ class: [ :table , "table-striped" ] }
    = passenger_survey_header_of_table( type , make_graph )
    = passenger_survey_body_of_table( list_of_passenger_surveys , type , make_graph )
    HAML
  end

  def passenger_survey_right_contents
    render inline: <<-HAML , type: :haml
%div{ id: :links_to_passenger_survey_pages }
  %ul{ class: :links }
    %li
      = "年度別の乗降客数"
      %ul
        %li
          = link_to_unless_current( "2011年度"  , "in_2011")
        %li
          = link_to_unless_current( "2012年度"  , "in_2012")
        %li
          = link_to_unless_current( "2013年度"  , "in_2013")
    %li
      = "路線別の乗降客数"
      %ul{ class: :link_to_lines }
        - ::RailwayLine.tokyo_metro.each do | railway_line |
          %li{ class: railway_line.css_class_name }
            = link_to_unless_current( railway_line.name_ja  , railway_line.css_class_name + "_line" )
    %li
      = "各駅の乗降客数"
    HAML
  end

  def passenger_survey_of_station
    survey_year = ::ApplicationHelper.latest_passenger_survey_year
    journey = @station.passenger_surveys.find_by_year( survey_year )
    if journey.blank?
      journey = "xxxxxx"
    else
      journey = number_separated_by_comma( journey.passenger_journey )
    end
    render inline: <<-HAML , type: :haml , locals: { survey_year: survey_year , journey: journey }
%div{ id: :passenger_survey_of_station }
  %span{ class: :title }<
    = "1日平均乗降人員"
  %span{ class: :passenger_journey }<
    %span{ class: :text_en }<>
      = journey
    = "人"
  %span{ class: :year }<
    = "（"
    %span{ class: :text_en }<>
      = survey_year
    = "年度）"
    HAML
  end

  private

  # タイトルを記述するメソッド（路線別・年度別 共通部分）
  def passenger_survey_common_title( type = nil )
    render inline: <<-HAML , type: :haml , locals: { type: type }
- case type
- when :railway_line
  - name_ja = "#{passenger_survey_common_title_ja}（路線別）"
- when :year
  - name_ja = "#{passenger_survey_common_title_ja}（年度別）"
- when :station
  - name_ja = "#{passenger_survey_common_title_ja}（駅別）"
- when nil
  - name_ja = passenger_survey_common_title_ja
= title_of_main_contents( name_ja , passenger_survey_common_title_en )
    HAML
  end

  # タイトルを記述するメソッド（年度別・色）
  def passenger_survey_year_in_title( year )
    render inline: <<-HAML , type: :haml , locals: { year: year }
%div{ class: :main_text }
  - # 年度を記述するメソッド
  %div{ class: :year }
    %h2{ class: :text_ja }<
      %span{ class: :text_en }<>
        = year
      = "年度"
    %h3{ class: :text_en }<
      = "In #{year}"
    HAML
  end

  def passenger_survey_header_of_table( type , make_graph )
    render inline: <<-HAML , type: :haml , locals: { type: type , make_graph: make_graph }
%thead{ id: :header_of_passenger_survey_table }
  %td<
    = "順位"
  %td<
    = "駅"
  - if type == :railway_line
    %td<
      = "調査年度"
  - if make_graph
    %td{ colspan: 2 }<
      = "乗降客数"
  - else
    %td<
      = "乗降客数"
    HAML
  end

  def passenger_survey_body_of_table( list_of_passenger_surveys , type , make_graph )
    h_locals = {
      list_of_passenger_surveys: list_of_passenger_surveys ,
      type: type ,
      make_graph: make_graph
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%tbody
  - passenger_journey_max = ( list_of_passenger_surveys.first.passenger_journey * 1.0 / 50000 ).ceil * 50000
  - list_of_passenger_surveys.each.with_index(1) do | data_of_station , i |
    - # svg_id = "passengers_of_" + data_of_station.stations.first.name_in_system
    - svg_id = "passengers_" + i.to_s
    - stations = data_of_station.stations
    %tr{ class: :passenger_survey_table_row , class: cycle( :odd_row , :even_row ) , "data-href" => [ stations ].flatten.first.name_in_system.underscore }
      %td{ class: [ :order , :text_en ] }<
        = i
      %td{ class: :station_info }
        - case type
        - when :railway_line
          %div{ class: [ :station_codes , :text_en ] }<
            = passenger_survey_station_codes_in_table( stations )
          %div{ class: :text }<
            = station_text( stations )
        - when :year
          %div{ class: :station_codes }
            = passenger_survey_station_codes_in_table( stations )
          %div{ class: :text }<
            = station_text( stations )
      - case type
      - when :railway_line
        %td{ class: [ :survey_year , :text_en ] }<
          = data_of_station.survey_year
      %td{ class: [ :passenger_journey , :text_en ] }<
        = number_separated_by_comma( data_of_station.passenger_journey )
      %td{ class: :graph }
        %svg{ id: svg_id }
          - width_max = 120
          - width_of_rect = [ ( data_of_station.passenger_journey * 1.0 / passenger_journey_max * width_max ).round , width_max ].min
          = tag( :rect , x: 0 , y: 0 , width: width_of_rect , height: 20 )
- # %td{ class: :comparison }
- # = compare_with_other_year( data_of_station )
    HAML
  end

  def passenger_survey_station_codes_in_table( stations )
    if @railway_lines_including_branch.blank?
      @railway_lines_including_branch = ::RailwayLine.tokyo_metro_including_branch
    end

    stations_displayed = stations.in_railway_line( @railway_lines_including_branch.pluck( :id ).flatten )
    display_images_of_station_codes( stations_displayed , true )
  end

  def passenger_survey_common_title_ja
    "各駅の乗降客数"
  end

  def passenger_survey_common_title_en
    "Passenger survey"
  end

end