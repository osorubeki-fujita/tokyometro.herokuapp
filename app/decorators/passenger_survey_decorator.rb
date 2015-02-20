class PassengerSurveyDecorator < Draper::Decorator
  delegate_all
  
  include CommonTitleRenderer
  
  def self.common_title_ja( type = nil )
    str = "各駅の乗降客数"
    case type
    when :railway_line
      str += "（路線別）"
    when :year
      str += "（年度別）"
    when :station
      str += "（駅別）"
    end
    str
  end

  def self.common_title_en
    "Passenger survey"
  end
  
  # タイトルを記述するメソッド（路線別・年度別 共通部分）
  def self.render_common_title( type = nil , text_en: common_title_en )
    super( text_ja: common_title_ja( type ) , text_en: text_en )
  end

  # タイトルを記述するメソッド（年度別・色）
  def self.render_year_in_title( year )
    h.render inline: <<-HAML , type: :haml , locals: { year: year }
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

  def self.render_right_contents
    h.render inline: <<-HAML , type: :haml
%div{ id: :links_to_passenger_survey_pages }
  %ul{ class: :links }
    %li<
      = "年度別の乗降客数"
      %ul<
        - [ 2011 , 2012 , 2013 ].each do | year |
          %li<
            = link_to_unless_current( year.to_s + "年度"  , "in_" + year.to_s )
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

  def self.render_header_of_table( type , make_graph )
    h.render inline: <<-HAML , type: :haml , locals: { type: type , make_graph: make_graph }
%thead{ id: :header_of_passenger_survey_table }
  - case type
  - when :year , :railway_line
    %td{ class: :order }<
      = "順位"
  %td{ class: :station }<
    = "駅"
  - case type
  - when :railway_line , :station
    = ::PassengerSurveyDecorator.render_year_header
  - if make_graph
    %td{ colspan: 2 , class: :passenger_journeys }<
      = "乗降客数"
  - else
    %td{ class: :passenger_journeys }<
      = "乗降客数"
    HAML
  end
  
  def self.render_year_header
    h.render inline: <<-HAML , type: :haml
%td{ class: :survey_year }<
  = "調査年度"
    HAML
  end

  def self.render_body_of_table( passenger_survey_infos , type , make_graph )
    h_locals = {
      passenger_survey_infos: passenger_survey_infos ,
      type: type ,
      make_graph: make_graph
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tbody
  - passenger_journey_max = ::PassengerSurveyDecorator.max_journeys_in_multiple_datas( passenger_survey_infos )
  - passenger_survey_infos.each.with_index(1) do | passenger_survey_info , i |
    = passenger_survey_info.decorate.render_table_row( i , passenger_journey_max , type , make_graph )
    HAML
  end

  def self.max_journeys_in_multiple_datas( passenger_surveys )
    base = 20000
    ( passenger_surveys.pluck( :passenger_journeys ).max * 1.0 / base ).ceil * base
  end

  def passenger_journeys_separated_by_comma
    h.number_separated_by_comma( object.passenger_journeys )
  end

  alias :journeys_separated_by_comma :passenger_journeys_separated_by_comma
  
  def svg_id(i)
    "passengers_#{i}_#{station_name_in_system}"
  end

  def width_of_svg_rectangle( passenger_journey_max )
    width_max = 120
    [ ( object.passenger_journeys * 1.0 / passenger_journey_max * width_max ).round , width_max ].min
  end
  
  def render_table_row( i , passenger_journey_max , type , make_graph )
    h_locals = {
      passenger_survey_info: self ,
      i: i ,
      passenger_journey_max: passenger_journey_max ,
      type: type ,
      make_graph: make_graph
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%tr{ class: [ :passenger_survey_table_row , cycle( :odd_row , :even_row ) ] , "data-href" => passenger_survey_info.station_name_in_system }
  - case type
  - when :railway_line , :year
    %td{ class: [ :order , :text_en ] }<
      = i
  %td{ class: :station_info }
    - stations = passenger_survey_info.stations
    - case type
    - when :railway_line , :year , :station
      %div{ class: :station_codes }<
        = passenger_survey_station_codes_in_table( stations )
      %div{ class: :text }<
        = stations.first.decorate.render_name_ja_and_en
  - case type
  - when :railway_line , :station
    %td{ class: [ :survey_year , :text_en ] }<
      = passenger_survey_info.survey_year
  %td{ class: [ :passenger_journey , :text_en ] }<
    = passenger_survey_info.journeys_separated_by_comma
  - if make_graph
    %td{ class: :graph }
      %svg{ id: passenger_survey_info.svg_id(i) }
        = tag( :rect , x: 0 , y: 0 , width: passenger_survey_info.width_of_svg_rectangle( passenger_journey_max ) , height: 20 )
- # %td{ class: :comparison }
- # = compare_with_other_year( data_of_station )
    HAML
  end

  def render_journeys_of_each_station
    h.render inline: <<-HAML , type: :haml , locals: { passenger_survey_info: self }
%div{ id: :passenger_survey_of_station }
  %span{ class: :title }<
    = "1日平均乗降人員"
  %span{ class: :passenger_journey }<
    %span{ class: :text_en }<>
      = passenger_survey_info.journeys_separated_by_comma
    = "人"
  %span{ class: :year }<
    = "（"
    %span{ class: :text_en }<>
      = passenger_survey_info.survey_year
    = "年度）"
    HAML
  end

end