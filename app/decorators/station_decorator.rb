class StationDecorator < Draper::Decorator

  delegate_all

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
  
  def render_name_ja( with_subname: true , suffix: nil )
    render_name_ja_or_hira( name_ja , with_subname , suffix )
  end
  
  def render_name_hira( with_subname: true , suffix: nil )
    render_name_ja_or_hira( name_hira , with_subname , suffix )
  end
  
  def render_name_ja_or_hira( name_ja_or_hira , with_subname , suffix )
    regexp = ::ApplicationHelper.regexp_for_parentheses_ja
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
    regexp = ::ApplicationHelper.regexp_for_parentheses_en
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
    - # = display_station_codes( station , all_station_codes )
    = display_images_of_station_codes( info.object , all_station_codes )
    HAML
  end
  
  def render_station_facility_title
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :station_facility_title }
  = ::StationFacilityDecorator.render_common_title
  = info.render_header( station_code: true , all_station_codes: true )
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
    - h.each do | body , title |
      %div{ class: :link }<
        = link_to_unless_current( title , "../" + body.to_s + "/" + info.name_in_system.underscore )
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
  = display_images_of_station_codes( info , false )
  %div{ class: :station_name }<
    %div{ class: :text_ja }<
      = info.decorate.render_name_ja
    %div{ class: :text_en }<
      = info.name_en
    HAML
  end

end