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
      name_main_txt = name_main + "&nbsp;"
      h.render inline: <<-HAML , type: :haml , locals: h_locals.merge({ name_main_txt: name_main_txt })
= raw( name_main_txt )
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

  def render_link_to_page_of_connecting_other_stations( controller )
    _c_railway_lines = connecting_railway_lines_of_the_same_operator_connected_to_another_station
    if _c_railway_lines.present?
      station_facility_info_ids = _c_railway_lines.map( &:connecting_station_info ).uniq.map( &:station_facility_info_id ).uniq
      station_infos = station_facility_info_ids.map { | station_facility_info_id | ::StationFacility::Info.find( station_facility_info_id ).station_infos.first }
      h_locals = {
        request: h.request ,
        station_infos: station_infos ,
        controller: controller
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ id: :list_of_links_to_station_facility_page_of_connecting_other_stations , class: :clearfix }
  - station_infos.each do | station_info |
    %li{ class: [ :normal , :clearfix ] }
      = link_to( "" , url_for( controller: controller , action: :action_for_station_page , station: station_info.station_page_name ) , class: :link )
      %div{ class: [ controller , :link_to_content , :clearfix ] }
        - unless controller.to_s == "station_facility"
          %div{ class: :icon }
            = ::TokyoMetro::App::Renderer::Icon.send( controller , request , 1 ).render
            - # = ::TokyoMetro::App::Renderer::Icon.tokyo_metro( request , 1 ).render
        - else
          %div{ class: :icon }
            %div{ class: :icon_img }<
        %div{ class: :text }
          = station_info.decorate.render_name_ja_and_en( suffix_ja: "駅" , prefix_en: "Information of " , suffix_en: " Sta." )
      HAML
    end
  end

  def render_title_of_links_to_station_info_pages( request )
    ::TokyoMetro::App::Renderer::Concerns::Header::Content.new(
      request ,
      :title ,
      :station ,
      render_name_ja( with_subname: true , suffix: "駅に関するご案内" ) ,
      render_name_en( with_subname: true , prefix: "Other pages related to " , suffix: " Sta." ) ,
      icon_size: 3
    ).render
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
      h_locals = { this: self , linked_page_name: object.name_in_system.underscore }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%td{ class: [ :station_info , :with_link ] , "data-href" => linked_page_name }<
  - linked_page = url_for( railway_line: this.railway_line.decorate.page_name , station: linked_page_name )
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
  = ::StationFacility::InfoDecorator.render_common_title( request )
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
  = ::TrainOperation::InfoDecorator.render_common_title( request )
  = info.render_header( station_code: true , all_station_codes: true )
    HAML
  end

  def render_link_to_station_in_matrix( type_of_link_to_station , set_anchor: false )
    @type_of_link_to_station = type_of_link_to_station
    h.render inline: <<-HAML , type: :haml , locals: { this: self , set_anchor: set_anchor }
%li{ class: :station }<
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
      station_page_name: station_page_name ,
      railway_line: r ,
      # title: title.link_to_station_page.ja ,
      set_anchor: set_anchor ,
      datum_for_tooltip: datum_for_tooltip
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if railway_line.present?
  - if set_anchor
    %a{ datum_for_tooltip , href: url_for( action: :action_for_station_page , station: station_page_name , anchor: railway_line , only_path: true ) }<
      = this.render_name_ja
  - else
    - url = url_for( action: :action_for_station_page , station: station_page_name , railway_line: railway_line )
    %a{ datum_for_tooltip , href: url }<
      = this.render_name_ja
- else
  %a{ datum_for_tooltip , href: url_for( action: :action_for_station_page , station: station_page_name ) }<
    = this.render_name_ja
    HAML
  end

  def render_link_to_station_page_en
    h.link_to( name_en , station_page_name , datum_for_tooltip )
  end

  def render_link_to_station_facility_page_ja
    link_name = "#{ name_ja_actual }駅のご案内へジャンプします。"
    if add_anchor_to_link_to_station_facility_page_ja?
      h.link_to( "" , h.url_for( controller: :station_facility , action: :action_for_station_page , station: station_page_name , anchor: anchor_added_to_link_of_station_faility_page ) , name: link_name )
    else
      h.link_to( "" , h.url_for( controller: :station_facility , action: :action_for_station_page , station: station_page_name ) , name: link_name )
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

  def station_codes
    ary = object.station_infos_including_other_railway_lines.select_tokyo_metro.map( &:station_code )
    if at_ayase?
      ary.uniq
    else
      ary
    end
  end

=begin
  def title
    ::Station::InfoDecorator::Title.new( self )
  end
=end

  def google_map
    ::Station::InfoDecorator::InGoogleMap.new( self )
  end

  def train_location
    ::Station::InfoDecorator::InTrainLocation.new( self )
  end

  def on_station_facility_page
    ::Station::InfoDecorator::OnStationFacilityPage.new( self )
  end

  private

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
      object.railway_line.main_railway_line.decorate.page_name
    else
      object.railway_line.decorate.page_name
    end
  end

  def anchor_added_to_link_of_station_faility_page
    if @type_of_link_to_station == :must_link_to_railway_line_page_and_merge_yf and between_wakoshi_and_kotake_mukaihara?
      "yurakucho_and_fukutoshin_line"
    else
      object.railway_line.decorate.page_name
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

  def datum_for_tooltip
    { 'data-station_code_images' => station_codes.join( '/' ) , 'data-text_ja' => object.name_ja , 'data-text_hira' => object.name_hira , 'data-text_en' => object.name_en }
  end

end
