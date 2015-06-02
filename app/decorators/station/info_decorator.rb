class Station::InfoDecorator < Draper::Decorator

  delegate_all

  decorates_association :station_facility

  def name_ja_actual
    object.name_ja.revive_machine_dependent_character
  end

  def name_ja_in_direction_info
    "#{ name_ja_actual }方面"
  end

  def name_en_in_direction_info
    "for #{ name_en }"
  end

  def name_ja_with_station_code
    name_with_station_code( name_ja_actual )
  end

  def name_en_with_station_code
    name_with_station_code( name_en )
  end

  def name_ja_and_en_with_station_code
    name_ja_with_station_code + " (#{name_en})"
  end

  def connecting_railway_lines_of_the_same_operator_connected_to_another_station
    connecting_railway_line_infos.includes( :railway_line ).order( :railway_line_id ).select { | item |
      item.railway_line.tokyo_metro? and item.connecting_to_another_station?
    }
  end

  def connecting_railway_lines_except_for_tokyo_metro
    connecting_railway_line_infos.includes( :railway_line ).order( :railway_line_id ).select { | item |
      item.railway_line.not_tokyo_metro?
    }
  end

  def link_title_to_station_page_ja
    "#{ station_codes_in_link_title } #{ name_ja_actual } - #{ name_hira } (#{ name_en }) "
  end

  def link_title_to_station_page_en
    "#{ station_codes_in_link_title } #{ name_en } - #{ name_ja_actual } （#{ name_hira }）"
  end

  def render_name_ja( with_subname: true , prefix: nil , suffix: nil )
    render_name_ja_or_hira( name_ja_actual , with_subname , prefix , suffix )
  end

  def render_name_hira( with_subname: true , prefix: nil , suffix: nil )
    render_name_ja_or_hira( name_hira , with_subname , prefix , suffix )
  end

  def render_name_ja_or_hira( name_ja_or_hira , with_subname , prefix , suffix )
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_ja
    if regexp =~ name_ja_or_hira
      name_main = name_ja_or_hira.gsub( regexp , "" ).revive_machine_dependent_character
      name_sub = $1
    else
      name_main = name_ja_or_hira.revive_machine_dependent_character
      name_sub = nil
    end

    if prefix.present?
      name_main = prefix.to_s + name_main
    end

    h.render inline: <<-HAML , type: :haml , locals: { name_main: name_main , name_sub: name_sub , with_subname: with_subname , suffix: suffix }
- if name_sub.present? and with_subname
  = name_main
  %span{ class: :small }<>
    != name_sub
  - if suffix.present?
    = suffix
- elsif suffix.present?
  = ( name_main + suffix )
- else
  = name_main
    HAML
  end

  def render_name_en( with_subname: true , prefix: nil , suffix: nil )
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_quotation
    if regexp =~ name_en
      name_main = name_en.gsub( regexp , "" )
      name_sub = $1
    else
      name_main = name_en
      name_sub = nil
    end

    if prefix.present?
      name_main = prefix + name_main
    end

    h_locals = {
      name_main: name_main ,
      name_sub: name_sub ,
      with_subname: with_subname ,
      suffix: suffix
    }

    if name_sub.present? and with_subname
      h.render inline: <<-HAML , type: :haml , locals: h_locals
= raw( name_main + "&nbsp;" )
%span{ class: :small }<>
  = name_sub
- if suffix.present?
  = suffix
      HAML

    elsif suffix.present?
      h.render inline: <<-HAML , type: :haml , locals: h_locals
= ( name_main + " " + suffix )
      HAML
    else
      h.render inline: <<-HAML , type: :haml , locals: h_locals
= name_main
      HAML
    end
  end

  def render_name_ja_and_en( with_subname: true , suffix_ja: nil , prefix_en: nil , suffix_en: nil )
    h.render inline: <<-HAML , type: :haml , locals: { this: self , with_subname: with_subname , suffix_ja: suffix_ja , prefix_en: prefix_en , suffix_en: suffix_en }
%p{ class: :text_ja }<>
  = this.render_name_ja( with_subname: with_subname , suffix: suffix_ja )
%p{ class: :text_en }<
  = this.render_name_en( with_subname: with_subname , prefix: prefix_en , suffix: suffix_en )
    HAML
  end

  # タイトルのメイン部分（駅名）を記述するメソッド
  def render_header( station_code: false , all_station_codes: false )
    if !( station_code ) and all_station_code
      raise "Error"
    end

    h_locals = { this: self , station_code: station_code , all_station_codes: all_station_codes }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :main_text }
  %div{ class: [ :station_name , :tokyo_metro ] }
    %h2{ class: :text_ja }<
      = this.render_name_ja( with_subname: true )
    %h3<
      %span{ class: :text_hira }<>
        = this.render_name_hira( with_subname: true )
      %span{ class: :text_en }<
        = this.render_name_en( with_subname: true )
  - if station_code
    = this.render_station_code_image( all: all_station_codes )
    HAML
  end

  # 東京メトロの路線情報を表示する method
  def render_tokyo_metro_railway_lines( request )
    h_locals = {
      this: self ,
      request: request ,
      railway_lines_of_tokyo_metro: railway_lines_of_tokyo_metro ,
      c_railway_lines: connecting_railway_lines_of_the_same_operator_connected_to_another_station
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :tokyo_metro_railway_lines }
  = ::ConnectingRailwayLine::InfoDecorator.render_title_of_tokyo_metro_railway_lines_in_station_facility_info
  %ul{ id: :railway_lines_in_this_station , class: [ :railway_lines , :clearfix ] }
    - railway_lines_of_tokyo_metro.each do | railway_line |
      = ::TokyoMetro::App::Renderer::RailwayLine::LinkToPage.new( request , railway_line.decorate ).render
  - if c_railway_lines.present?
    %ul{ id: :railway_lines_in_another_station , class: [ :railway_lines , :clearfix ] }
      - c_railway_lines.each do | connecting_railway_line_info |
        = ::TokyoMetro::App::Renderer::ConnectingRailwayLine::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
    HAML
  end

  def render_link_to_station_facility_info_of_connecting_other_stations
    _c_railway_lines = connecting_railway_lines_of_the_same_operator_connected_to_another_station
    if _c_railway_lines.present?
      station_facility_ids = _c_railway_lines.map( &:connecting_station_info ).uniq.map( &:station_facility_id ).uniq
      station_infos = station_facility_ids.map { | station_facility_id | ::StationFacility.find( station_facility_id ).station_infos.first }
      h_locals = {
        request: h.request ,
        station_infos: station_infos
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ id: :links_to_station_facility_info_of_connecting_other_stations , class: :clearfix }
  - station_infos.each do | station_info |
    %li{ class: [ :link_to_station_facility , :normal ] }
      = link_to( "" , url_for( controller: :station_facility , action: station_info.station_page_name ) , class: :link )
      %div{ class: [ :link_to_content , :clearfix ] }
        %div{ class: :icon }
          = ::TokyoMetro::App::Renderer::Icon.tokyo_metro( request , 1 ).render
        %div{ class: :text }
          = station_info.decorate.render_name_ja_and_en( suffix_ja: "駅のご案内" , prefix_en: "Information of " , suffix_en: " Sta." )
      HAML
    end
  end

  # 他事業者の乗り換え情報を表示する method
  def render_railway_lines_except_for_tokyo_metro
    # @param c_railway_lines [Array <RailwayLine>] 東京メトロ以外の乗り入れ路線
    _connecting_railway_lines_except_for_tokyo_metro = connecting_railway_lines_except_for_tokyo_metro

    if _connecting_railway_lines_except_for_tokyo_metro.present?
      h_locals = {
        c_railway_lines: _connecting_railway_lines_except_for_tokyo_metro
      }

      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :other_railway_lines }
  = ::ConnectingRailwayLine::InfoDecorator.render_title_of_other_railway_lines_in_station_facility_info
  %ul{ id: :railway_lines_except_for_tokyo_metro , class: [ :railway_lines , :clearfix ] }
    - c_railway_lines.each do | connecting_railway_line_info |
      = ::TokyoMetro::App::Renderer::ConnectingRailwayLine::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
      HAML
    end
  end

  def render_title_of_links_to_station_info_pages
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :title }
  %h2{ class: :text_ja }<
    = this.render_name_ja( with_subname: true , suffix: "駅に関するご案内" )
  %h3{ class: :text_en }<
    = this.render_name_en( with_subname: true , prefix: "Other pages related to " , suffix: "Station" )
    HAML
  end

  # @note {ConnectingRailwayLineDecorator#render} から呼び出される。
  def render_connection_info_from_another_station
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :another_station }
  %div{ class: :text_ja }<
    = this.decorate.render_name_ja( with_subname: false , suffix: this.attribute_ja )
  %div{ class: :text_en }<
    = this.decorate.render_name_en( with_subname: false , suffix: this.attribute_en_short.capitalize )
    HAML
  end

  def render_fare_title_of_this_station( *railway_lines )
    railway_line = railway_lines.flatten.first
    h.render inline: <<-HAML , type: :haml , locals: { this: self , railway_line: railway_line }
%div{ class: :top_title }
  %h2{ class: :text_ja }<
    = this.render_name_ja( with_subname: true , suffix: "駅から#{ railway_line.name_ja }各駅までの運賃" )
  %h3{ class: :text_en }<
    = this.render_name_en( with_subname: true , prefix: "Fares from " , suffix: " to stations on #{ railway_line.name_en }" )
    HAML
  end

  def render_direction_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :text_ja }<
  = this.name_ja_in_direction_info
%div{ class: :text_en }<
  = this.name_en_in_direction_info
    HAML
  end

  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :additional_infos }
  = this.render_station_code_image( all: false )
  %div{ class: :station_name }<
    %div{ class: :text_ja }<
      = this.render_name_ja
    %div{ class: :text_en }<
      = this.name_en
    HAML
  end

  def render_in_fare_table( starting_station_info: false )
    if starting_station_info
      h_locals = { this: self }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :station_info , :starting_station] }<
  = this.render_in_fare_table_without_link
      HAML
    else
      h_locals = { this: self , linked_page_action: object.name_in_system.underscore }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :station_info , :with_link ] , "data-href" => linked_page_action }<
  - linked_page = url_for( action: linked_page_action ) + "/" + this.railway_line.css_class_name + "_line"
  = link_to( "" , linked_page )
  = this.render_in_fare_table_without_link
      HAML
    end
  end

  def render_in_fare_table_without_link
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :station_info_domain }
  %div{ class: :station_code_outer }
    = this.render_station_code_image( all: false )
  %div{ class: [ :text , :clearfix ] }
    = this.render_name_ja_and_en
    HAML
  end

  def render_station_code_image( all: false )
    if at_ayase? or at_nakano_sakaue?
      ::TokyoMetro::App::Renderer::StationCode::Normal.new( nil , self ).render
    elsif tokyo_metro?
      if all
        ::TokyoMetro::App::Renderer::StationCode::Normal.new( nil , station_infos_including_other_railway_lines ).render
      else
        ::TokyoMetro::App::Renderer::StationCode::Normal.new( nil , self ).render
      end

    else

      h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :station_codes }<
  = "\[" + this.station_code + "\]"
      HAML

    end
  end

  def render_each_station_code_image_tag
    h.image_tag( code_image_filename , class: :station_code )
  end

  def render_title_of_passenger_survey
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( request , :station )
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  # タイトルを記述するメソッド
  def render_title_of_fare
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :fare_title }
  = ::FareDecorator.render_common_title( request )
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_title_of_station_facility
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :station_facility_title }
  = ::StationFacilityDecorator.render_common_title( request )
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_title_of_station_timetable
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :station_facility_title }
  = ::StationTimetableDecorator.render_common_title( request )
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_title_of_train_operation_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ id: :train_operation_info_title }
  = ::TrainInformationDecorator.render_common_title( request )
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_link_to_station_in_matrix( type_of_link_to_station , set_anchor: false )
    @type_of_link_to_station = type_of_link_to_station
    h.render inline: <<-HAML , type: :haml , locals: { this: self , set_anchor: set_anchor }
%div{ class: :station }<
  = this.render_link_to_station_page_ja( set_anchor: set_anchor )
    HAML
  end

  def render_link_to_station_page_ja( set_anchor: false )
    if link_to_station_page_for_each_railway_line?
      r = railway_line_in_station_page
    else
      r = nil
    end
    h_locals = {
      this: self ,
      action: station_page_name ,
      railway_line: r ,
      title: link_title_to_station_page_ja ,
      set_anchor: set_anchor
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if railway_line.present?
  - if set_anchor
    %a{ href: url_for( action: action , anchor: railway_line , only_path: true ) , title: title }<
      = this.render_name_ja
  - else
    %a{ href: url_for( action: action ) + "/" + railway_line , title: title }<
      = this.render_name_ja
- else
  %a{ href: url_for( action: action ) , title: title }<
    = this.render_name_ja
    HAML
  end

  def render_link_to_station_page_en
    h.link_to( name_en , station_page_name , title: link_title_to_station_page_en )
  end

  def render_link_to_station_facility_page_ja
    link_name = "#{ name_ja_actual }駅のご案内へジャンプします。"
    if add_anchor_to_link_to_station_facility_page_ja?
      h.link_to( "" , h.url_for( controller: :station_facility , action: station_page_name , anchor: anchor_added_to_link_of_station_faility_page ) , name: link_name )
    else
      h.link_to( "" , h.url_for( controller: :station_facility , action: station_page_name ) , name: link_name )
    end
  end

  def render_latest_passenger_survey
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ id: :passenger_survey_of_station , class: :clearfix }
  %div{ class: :data }
    - icon_instance_of_passenger_survey = ::TokyoMetro::App::Renderer::Icon.passenger_survey( request , 1 )
    = link_to( icon_instance_of_passenger_survey.render , url_for( controller: :passenger_survey , action: :action_for_station_page , station: this.object.name_in_system.underscore , anchor: nil ) , class: :icon )
    %div{ class: :text_ja }
      = this.latest_passenger_survey.decorate.render_journeys_of_each_station
    HAML
  end

  def render_travel_time_info_square
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
    HAML
  end

  def render_name_in_travel_time_infos
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.render_link_to_station_facility_page_ja
%div{ class: [ :station_info_domain , :clearfix ] }
  = this.render_station_code_image( all: false )
  %div{ class: :text }<
    = this.render_name_ja_and_en
    HAML
  end

  def render_connecting_railway_lines_in_travel_time_infos
    h_locals = {
      c_railway_line_infos: object.connecting_railway_line_infos.display_on_railway_line_page.includes( :railway_line , railway_line: :operator )
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ class: [ :railway_lines , :clearfix ] }
  - c_railway_line_infos.each do | connecting_railway_line_info |
    = ::TokyoMetro::App::Renderer::TravelTimeInfo::MetaClass::Row::Station::LinkToRailwayLinePage.new( request , connecting_railway_line_info.decorate ).render
    HAML
  end

  def render_name_ja_in_station_timetable
    h_locals = { this: self }
    if name_ja_actual.length <= 4
      h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :destination }<
  = this.render_name_ja( with_subname: false )
      HAML
    else
      h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.render_name_ja_long
      HAML
    end
  end

  def render_name_ja_long
    _splited_destination_name_ja = splited_destination_name_ja
    keys = _splited_destination_name_ja.keys
    h_locals = {
      normal_size_part: _splited_destination_name_ja[ :normal_size ] ,
      small_size_part: _splited_destination_name_ja[ :small_size ]
    }

    case keys
    when [ :normal_size , :small_size ]
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :destination }<
  = normal_size_part
  - if small_size_part.present?
    %span{ class: :small }<>
      = small_size_part
      HAML

    when [ :small_size , :normal_size ]
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :destination }<
  %span{ class: :small }<>
    = small_size_part
  = normal_size_part
      HAML

    else
      raise "Error"
    end
  end

  def google_map
    ::Station::InfoDecorator::InGoogleMap.new( self )
  end

  def train_location
    ::Station::InfoDecorator::InTrainLocation.new( self )
  end

  private

  def station_codes
    ary = object.station_infos_including_other_railway_lines.select_tokyo_metro.map( &:station_code )
    if at_ayase?
      ary.uniq
    else
      ary
    end
  end

  def station_codes_in_link_title
    "\[ #{ station_codes.join(" , " ) } \]"
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

  def link_to_station_page_for_each_railway_line?
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
    link_to_station_page_for_each_railway_line?
  end

  def railway_line_in_station_page
    if @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf and between_wakoshi_and_kotake_mukaihara?
      "yurakucho_and_fukutoshin_line"
    elsif object.railway_line.is_branch_line?
      "#{ object.railway_line.main_railway_line.css_class_name }_line"
    else
      "#{object.railway_line.css_class_name}_line"
    end
  end

  def anchor_added_to_link_of_station_faility_page
    if @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf and between_wakoshi_and_kotake_mukaihara?
      "yurakucho_and_fukutoshin_line"
    else
      "#{object.railway_line.css_class_name}_line"
    end
  end

  def name_with_station_code( station_name )
    str = ::String.new
    if station_code.present?
      str << "\[#{ station_code }\] "
    end
    str << station_name
    str
  end

  def splited_destination_name_ja
    destination_name_ja = name_ja_actual.delete_station_subname
    case destination_name_ja
    when "中野富士見町"
      { small_size: "中野" , normal_size: "富士見町" }
    when "東武動物公園"
      { normal_size: "東武" , small_size: "動物公園" }
    when "代々木上原"
      { small_size: "代々木" , normal_size: "上原" }
    when "明治神宮前"
      { normal_size: "明治" , small_size: "神宮前" }
    when "新宿三丁目"
      { normal_size: "新宿" , small_size: "三丁目" }
    when "石神井公園"
      { normal_size: "石神井" , small_size: "公園" }
    when "元町・中華街"
      { normal_size: "元町" , small_size: "・中華街" }
    else
      { normal_size: destination_name_ja , small_size: nil }
    end
  end

  def name_ja_url_encoded
    ::ERB::Util.url_encode( name_ja_actual )
  end

end
