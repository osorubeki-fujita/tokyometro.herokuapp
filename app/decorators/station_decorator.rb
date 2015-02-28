class StationDecorator < Draper::Decorator

  delegate_all

  decorates_association :station_facility

  include SubTopTitleRenderer

  def name_ja_in_direction_info
    "#{ name_ja }方面"
  end

  def name_en_in_direction_info
    "for #{ name_en }"
  end

  def connecting_railway_lines_of_tokyo_metro_in_another_station
    connecting_railway_lines.includes( :railway_line ).order( :railway_line_id ).select { | item | item.railway_line.tokyo_metro? and item.connecting_to_another_station? }
  end

  def connecting_railway_lines_except_for_tokyo_metro
    connecting_railway_lines.includes( :railway_line ).order( :railway_line_id ).select { | item | item.railway_line.not_tokyo_metro? }
  end
  
  def link_title_to_station_page_ja
    "#{ station_codes_in_link_title } #{ name_ja } - #{ name_hira } (#{ name_en }) "
  end
  
  def link_title_to_station_page_en
    "#{ station_codes_in_link_title } #{ name_en } - #{ name_ja } （#{ name_hira }）"
  end

  def render_name_ja( with_subname: true , suffix: nil )
    render_name_ja_or_hira( name_ja , with_subname , suffix )
  end

  def render_name_hira( with_subname: true , suffix: nil )
    render_name_ja_or_hira( name_hira , with_subname , suffix )
  end

  def render_name_ja_or_hira( name_ja_or_hira , with_subname , suffix )
    regexp = ::ApplicationHelper.regexp_for_parentheses_normal
    if regexp =~ name_ja_or_hira
      name_main = name_ja_or_hira.gsub( regexp , "" ).process_specific_letter
      name_sub = $1
    else
      name_main = name_ja_or_hira.process_specific_letter
      name_sub = nil
    end

    h.render inline: <<-HAML , type: :haml , locals: { name_main: name_main , name_sub: name_sub , with_subname: with_subname , suffix: suffix }
- if name_sub.present? and with_subname
  = name_main
  %span{ class: :small }<>
    = name_sub
  - if suffix.present?
    = suffix
- elsif suffix.present?
  = ( name_main + suffix )
- else
  = name_main
    HAML
  end

  def render_name_en( with_subname: true , suffix: nil )
    regexp = ::ApplicationHelper.regexp_for_parentheses_for_quotation
    if regexp =~ name_en
      name_main = name_en.gsub( regexp , "" )
      name_sub = $1
    else
      name_main = name_en
      name_sub = nil
    end

    h.render inline: <<-HAML , type: :haml , locals: { name_main: name_main , name_sub: name_sub , with_subname: with_subname , suffix: suffix }
- if name_sub.present? and with_subname
  = name_main
  %span{ class: :small }<>
    = ( " " + name_sub )
  - if suffix.present?
    = ( " " + suffix )
- elsif suffix.present?
  = ( name_main + " " + suffix )
- else
  = name_main
    HAML
  end

  def render_name_ja_and_en( with_subname: true , suffix_ja: nil , suffix_en: nil )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , with_subname: with_subname , suffix_ja: suffix_ja , suffix_en: suffix_en }
%div{ class: :text_ja }<>
  = info.render_name_ja( with_subname: with_subname , suffix: suffix_ja )
%div{ class: :text_en }<
  = info.render_name_en( with_subname: with_subname , suffix: suffix_en )
    HAML
  end

  # タイトルのメイン部分（駅名）を記述するメソッド
  def render_header( station_code: false , all_station_codes: false )
    if !( station_code ) and all_station_code
      raise "Error"
    end

    h.render inline: <<-HAML , type: :haml , locals: { info: self , station_code: station_code , all_station_codes: all_station_codes }
%div{ class: :main_text }
  %div{ class: [ :station_name , :tokyo_metro ] }
    %h2{ class: :text_ja }<
      = info.render_name_ja( with_subname: true )
    %h3<
      %span{ class: :text_hira }<>
        = info.render_name_hira( with_subname: true )
      %span{ class: :text_en }<
        = info.render_name_en( with_subname: true )
  - if station_code
    = info.render_station_code_image( all: all_station_codes )
    HAML
  end

  # 東京メトロの路線情報を表示する method
  def render_tokyo_metro_railway_lines
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :tokyo_metro_railway_lines }
  = ::ConnectingRailwayLineDecorator.render_title_of_tokyo_metro_railway_lines_in_station_facility_info
  %div{ class: :railway_lines }
    %div{ class: :railway_lines_in_this_station }
      - info.railway_lines_of_tokyo_metro.each do | railway_line |
        = railway_line.decorate.render_connecting_railway_line_info_in_station_facility
    - connecting_railway_lines_in_another_station = info.connecting_railway_lines_of_tokyo_metro_in_another_station
    - if connecting_railway_lines_in_another_station.present?
      %div{ class: :railway_lines_in_another_station }
        - connecting_railway_lines_in_another_station.each do | railway_line |
          = railway_line.decorate.render
    HAML
  end

  # 他事業者の乗り換え情報を表示する method
  def render_railway_lines_except_for_tokyo_metro
    _connecting_railway_lines_except_for_tokyo_metro = connecting_railway_lines_except_for_tokyo_metro
    if _connecting_railway_lines_except_for_tokyo_metro.present?
      h.render inline: <<-HAML , type: :haml , locals: { connecting_railway_lines_except_for_tokyo_metro: _connecting_railway_lines_except_for_tokyo_metro }
- # @param connecting_railway_lines [Array <RailwayLine>] 東京メトロ以外の乗り入れ路線
%div{ class: :other_railway_lines }
  = ::ConnectingRailwayLineDecorator.render_title_of_other_railway_lines_in_station_facility_info
  %div{ class: :railway_lines }
    - connecting_railway_lines_except_for_tokyo_metro.each do | connecting_railway_line |
      = connecting_railway_line.decorate.render
      HAML
    end
  end

  def render_links_to_infos
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :station_info_links }
  %div{ class: :station_name }<
    %h2{ class: :text_ja }<
      = info.render_name_ja( with_subname: true , suffix: "駅に関するご案内" )
    %h3{ class: :text_en }<
      = "Other pages related to " + info.name_en + " Station"
  %div{ class: :links }
    :ruby
      h = {
        train_information: "駅からの列車運行状況" ,
        station_timetable: "駅の時刻表" ,
        station_facility: "駅施設のご案内"
      }
    - h.each do | controller , title |
      %div{ class: :link }<
        = link_to_unless_current( title , url_for( controller: controller , action: info.name_in_system.underscore )
    HAML
  end

  def render_connection_info_from_another_station
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :another_station }
  %div{ class: :text_ja }<
    = info.decorate.render_name_ja( with_subname: false , suffix: info.attribute_ja )
  %div{ class: :text_en }<
    = info.decorate.render_name_en( with_subname: false , suffix: info.attribute_en_short.capitalize )
    HAML
  end

  def render_fare_title_of_this_station
    render_sub_top_title( text_ja: "#{ name_ja }駅から・までの運賃" , text_en: "Fares from/to #{ name_en } station" )
  end

  def render_direction_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :text_ja }<
  = info.name_ja_in_direction_info
%div{ class: :text_en }<
  = info.name_en_in_direction_info
    HAML
  end

  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :additional_infos }
  = info.render_station_code_image( all: false )
  %div{ class: :station_name }<
    %div{ class: :text_ja }<
      = info.decorate.render_name_ja
    %div{ class: :text_en }<
      = info.name_en
    HAML
  end

  def render_in_fare_table( starting_station: false )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , starting_station: starting_station }
- if starting_station
  %td{ class: [ :station_name , :starting_station ] }<
    = info.render_in_fare_table_without_link
- else
  = info.render_in_fare_table_with_link( linked_page: linked_page = info.object.name_in_system.underscore )
    HAML
  end

  def render_in_fare_table_without_link
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :station_code_outer }
  = info.render_station_code_image( all: false )
%div{ class: :station_name_text }
  %div{ class: :text_ja }
    = info.render_name_ja( with_subname: true )
  %div{ class: :text_en }
    = info.render_name_en( with_subname: true )
    HAML
  end

  def render_in_fare_table_with_link( linked_page: nil )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , linked_page: linked_page }
%td{ class: :station_name , "data-href" => linked_page }<
  %div{ class: :station_name_domain }
    - if linked_page.present?
      = link_to( "" , linked_page )
    = info.render_in_fare_table_without_link
    HAML
  end

  def render_station_code_image( all: false )
    if at_ayase?

      h.render inline: <<-HAML , type: :haml , locals: { info: self , all: all }
%div{ class: :station_codes }<
  = info.render_each_station_code_image_tag
      HAML

    else
      h.render inline: <<-HAML , type: :haml , locals: { info: self , all: all }
- if all
  %div{ class: :station_codes }<
    - info.stations_including_other_railway_lines.each do | station |
      = station.decorate.render_each_station_code_image_tag
- else
  %div{ class: :station_codes }<
    = info.render_each_station_code_image_tag
      HAML
    end
  end

  def render_station_code_images
    render_station_code_image( all: true )
  end

  def render_each_station_code_image_tag
    h.image_tag( code_image_filename , class: :station_code )
  end

  def render_title_of_passenger_survey
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( :station )
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  # タイトルを記述するメソッド
  def render_title_of_fare
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :fare_title }
  = ::FareDecorator.render_common_title
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_title_of_station_facility
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :station_facility_title }
  = ::StationFacilityDecorator.render_common_title
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_title_of_station_timetable
    render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :station_facility_title }
  = ::StationTimetableDecorator.render_common_title
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_title_of_train_information
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :train_information_title }
  = ::TrainInformationDecorator.render_common_title
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_link_to_station_in_matrix( type_of_link_to_station )
    @type_of_link_to_station = type_of_link_to_station
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :station }<
  = info.render_link_to_station_page_ja
    HAML
  end

  def render_link_to_station_page_ja
    if add_anchor_to_link_to_station_page_ja?
      h.link_to( name_ja , h.url_for( action: station_page_name , anchor: anchor_added_to_link_of_station_page ) , title: link_title_to_station_page_ja )
    else
      h.link_to( name_ja , station_page_name , title: link_title_to_station_page_ja )
    end
  end

  def render_link_to_station_page_en
    h.link_to( name_en , station_page_name , title: link_title_to_station_page_en )
  end

  def render_link_to_station_facility_page_ja
    link_name = "#{ name_ja }駅のご案内へジャンプします。"
    if add_anchor_to_link_to_station_facility_page_ja?
      h.link_to( "" , h.url_for( controller: :station_facility , action: station_page_name , anchor: anchor_added_to_link_of_station_faility_page ) , name: link_name )
    else
      h.link_to( "" , h.url_for( controller: :station_facility , action: station_page_name ) , name: link_name )
    end
  end
  
  def render_latest_passenger_survey
    latest_passenger_survey.decorate.render_journeys_of_each_station
  end

  def render_travel_time_info_square
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :travel_time_info_square }<
  = " "
    HAML
  end

  def render_travel_time_info_row( special_proc_of_station )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , special_proc_of_station: special_proc_of_station }
%tr
  - if special_proc_of_station.present?
    = special_proc_of_station.call( info )
  %td{ class: :railway_line_column }<
    = info.render_travel_time_info_square
  = info.render_in_travel_time_info
    HAML
  end

  def render_in_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%td{ class: :station_name }
  = info.render_link_to_station_facility_page_ja
  = info.render_station_code_image( all: false )
  %div{ class: :station }<
    = info.render_name_ja_and_en
%td{ class: :transfer , colspan: 2 }
  - info.connecting_railway_lines.includes( :railway_line , railway_line: :operator ).each do | connecting_railway_line |
    = connecting_railway_line.decorate.render
    HAML
  end

  def self.render_station_code_imags( stations )
    h.render inline: <<-HAML , type: :haml , locals: { infos: stations }
%div{ class: :station_codes }<
  - infos.each do | station |
    = station.decorate.render_each_station_code_image_tag
    HAML
  end

  class << self
    alias :render_station_code_images_in_passenger_survey_table_row :render_station_code_imags
  end

  private

  def station_codes
    ary = object.stations_including_other_railway_lines.select_tokyo_metro.map( &:station_code )
    if at_ayase?
      ary.uniq
    else
      ary
    end
  end

  def station_codes_in_link_title
    "\[ #{ station_codes.join(" , " ) } \]"
  end
  
  def name_ja
    object.name_ja.process_specific_letter
  end

  def code_image_filename
    dirname = "provided_by_tokyo_metro/station_number"
    if /\Am(\d{2})\Z/ =~ station_code
      file_basename = "mm#{$1}"
    else
      if station_code.nil?
        raise "Error: " + same_as
      end
      file_basename = station_code.downcase
    end
    "#{dirname}/#{file_basename}.png"
  end

  def add_anchor_to_link_to_station_page_ja?
    case @type_of_link_to_station
    when :must_link_to_railway_line_page , :must_link_to_railway_line_page_and_merge_yf
      true
    when :link_to_railway_line_page_if_containing_multiple_railway_lines
     has_another_railway_lines_of_tokyo_metro?
    when :link_to_railway_line_page_if_containing_multiple_railway_lines_and_merge_yf
     has_another_railway_lines_of_tokyo_metro? and !( between_wakoshi_and_kotake_mukaihara? )
    when nil
      false
    end
  end
  
  def add_anchor_to_link_to_station_facility_page_ja?
    @type_of_link_to_station = :link_to_railway_line_page_if_containing_multiple_railway_lines_and_merge_yf
    add_anchor_to_link_to_station_page_ja?
  end

  def anchor_added_to_link_of_station_page
    if @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf and between_wakoshi_and_kotake_mukaihara?
      :yurakucho_and_fukutoshin
    else
      object.railway_line.css_class_name
    end
  end
  
  alias :anchor_added_to_link_of_station_faility_page :anchor_added_to_link_of_station_page

end