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
    # when :station
      # str += "（駅別）"
    end
    str
  end

  def self.common_title_en
    "Passenger survey"
  end

  # タイトルを記述するメソッド（路線別・年度別 共通部分）
  def self.render_common_title( request , type = nil , text_en: common_title_en )
    super( request , text_ja: common_title_ja( type ) , text_en: text_en )
  end

  # タイトルを記述するメソッド（年度別）
  def self.render_title_when_grouped_by_year( year )
    h.render inline: <<-HAML , type: :haml , locals: { year: year }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( request , :year )
  = ::PassengerSurveyDecorator.render_year_in_title( year )
    HAML
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

  def self.link_to_year_page( survey_year )
    h.link_to_unless_current( "" , h.url_for( controller: :passenger_survey , action: :action_for_railway_line_or_year_page , railway_line: :all , survey_year: survey_year ) )
  end

  def passenger_journeys_separated_by_comma
    h.number_separated_by_comma( object.passenger_journeys )
  end

  alias :journeys_separated_by_comma :passenger_journeys_separated_by_comma
  
  def render_station_name_in_table( station_info = station_infos.first )
    h.render inline: <<-HAML , type: :haml , locals: { this: self , station_info: station_info }
- url_of_station_page = url_for( controller: :passenger_survey , action: :action_for_station_page , station: station_info.name_in_system.underscore )
- class_name_of_cell = [ :station_info ]
- unless current_page?( url_of_station_page )
  - class_name_of_cell << :with_link
- station_infos = this.station_infos
%td{ class: class_name_of_cell }
  = link_to_unless_current( "" , url_of_station_page )
  %div{ class: :station_info_domain }
    = ::TokyoMetro::App::Renderer::StationCode::Normal.new( request , station_infos , first_info: station_info ).render
    %div{ class: :text }<
      = station_infos.first.decorate.render_name_ja_and_en
    HAML
  end

  def render_survey_year_in_table
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- url_of_year_page = url_for( controller: :passenger_survey , action: :action_for_railway_line_or_year_page , railway_line: :all , survey_year: this.survey_year )
- class_name_of_cell = [ :survey_year , :text_en ]
- unless current_page?( url_of_year_page )
  - class_name_of_cell << :with_link
%td{ class: class_name_of_cell }<
  = link_to_unless_current( "" , url_of_year_page )
  = this.survey_year
    HAML
  end
  
  def render_passenger_journeys
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%td{ class: [ :passenger_journey , :text_en ] }<
  = this.journeys_separated_by_comma
    HAML
  end

  def render_journeys_of_each_station
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%span{ class: :title }<
  = "平均乗降人員"
%span{ class: :passenger_journey }<
  %span{ class: :text_en }<>
    = this.journeys_separated_by_comma
  = "人/日"
%span{ class: :year }<
  != "（"
  %span{ class: :text_en }<>
    = this.survey_year
  = "年度）"
    HAML
  end

end