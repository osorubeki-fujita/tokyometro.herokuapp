class RailwayLineDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer
  extend SubTopTitleRenderer

  include TwitterRenderer
  include CssClassNameOfConnectingRailwayLine
  include RenderLinkToRailwayLinePage

  def self.common_title_ja
    "路線のご案内"
  end

  def self.common_title_en
    "Information of railway lines"
  end

  # タイトルのメイン部分（路線色・路線名）を記述するメソッド
  def self.name_main( railway_lines )
    class << railway_lines
      include ForRails::RailwayLineArrayModule
    end

    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ class: :main_text }
  - # タイトルの路線名を記述
  %div{ class: infos.to_title_color_class }
    %h2{ class: :text_ja }<
      = infos.to_railway_line_name_text_ja
    %h3{ class: :text_en }<
      = infos.to_railway_line_name_text_en
    HAML
  end

  def self.render_title_of_railway_lines( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :railway_line_title }
  = ::RailwayLineDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_train_info
    render_sub_top_title( text_ja: "運行情報" , text_en: "Train information" )
  end

  # タイトルを記述するメソッド（路線別）
  def self.render_title_of_passenger_survey( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( request , :railway_line )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_station_facility( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :station_facility_title }
  = ::StationFacilityDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  # 列車運行情報のタイトルを記述するメソッド
  def self.render_title_of_train_information( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :train_information_title }
  = ::TrainInformationDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  # 列車位置情報のタイトルを記述するメソッド
  def self.render_title_of_train_location( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :train_location_title }
  = ::TrainLocationDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_station_timetable( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :station_timetable_title }
  = ::StationTimetableDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_title_of_railway_timetable( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :railway_timetable_title }
  = ::TokyoMetro::App::Renderer::Concern::Header::Title::Base.new( request , ::RailwayTimetableHelper.common_title_ja , ::RailwayTimetableHelper.common_title_en ).render
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  def self.render_travel_time_simple_infos_of_multiple_railway_lines( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
- railway_lines.each do | railway_line |
  %div{ class: :railway_line }
    = railway_line.decorate.render_travel_time_simple_infos
    HAML
  end

  def self.render_matrixes_of_all_railway_lines( including_yurakucho_and_fukutoshin: false , make_link_to_railway_line: true )
    h_locals = {
      including_yurakucho_and_fukutoshin: including_yurakucho_and_fukutoshin ,
      make_link_to_railway_line: make_link_to_railway_line
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :railway_line_matrixes }
  - ::RailwayLine.tokyo_metro( including_branch_line: false ).each do | railway_line |
    = railway_line.decorate.render_matrix( make_link_to_railway_line: make_link_to_railway_line )
  - if including_yurakucho_and_fukutoshin
    = ::RailwayLineDecorator.render_matrix_of_yurakucho_and_fukutoshin( make_link_to_railway_line )
    HAML
  end

  def self.render_matrix_of_yurakucho_and_fukutoshin( make_link_to_railway_line )
    h_locals = { make_link_to_railway_line: make_link_to_railway_line }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ :railway_line_matrix , :multiple_lines , :yurakucho_fukutoshin ] }
  - if make_link_to_railway_line
    = link_to( "" , "yurakucho_and_fukutoshin_line" )
  %div{ class: :info }
    %div{ class: :railway_line_codes }<
      %div{ class: :railway_line_code_block }
        - [ ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Yurakucho" ) , ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Fukutoshin" ) ].each do | railway_line |
          %div{ class: railway_line.css_class_name }<
            %div{ class: :railway_line_code_outer }<
              = railway_line.decorate.render_railway_line_code
    %div{ class: :text_ja }<
      = "有楽町線・副都心線"
    %div{ class: :text_en }<
      = "Yurakucho and Fukutoshin Line"
    HAML
  end

  def name_ja_with_operator_name( process_special_railway_line: false , prefix: nil , suffix: nil )
    if process_special_railway_line
      case object.same_as
      when "odpt.Railway:Seibu.SeibuYurakucho"
        str = "西武線"
      else
        str = object.name_ja_with_operator_name
      end
    else
      str = object.name_ja_with_operator_name
    end
    
    if prefix.present?
      str = prefix + str
    end
    if suffix.present?
      str += suffix
    end
    str
  end

  def name_en_with_operator_name( process_special_railway_line: false , prefix: nil , suffix: nil )
    if process_special_railway_line
      case object.same_as
      when "odpt.Railway:Seibu.SeibuYurakucho"
        str = "Seibu Line"
      else
        str = object.name_en_with_operator_name
      end
    else
      str = object.name_en_with_operator_name
    end
    
    if prefix.present?
      str = "#{ prefix } #{ str }"
    end
    if suffix.present?
      str = "#{ str } #{ suffix }"
    end
    str
  end

  def twitter_title
    "Twitter #{ object.name_ja } 運行情報"
  end

  def railway_line_in_station_facility_platform_info_transfer_info
    case same_as
    when "odpt.Railway:Tobu.SkyTreeIsesaki"
      "東武線"
    when "odpt.Railway:Seibu.SeibuYurakucho"
      "西武線"
    else
      object.name_ja_with_operator_name
    end
  end

  def railway_line_page_name
    if object.branch_line?
      "#{ css_class_name }_line".gsub( /_branch/ , "" ) 
    else
      "#{ css_class_name }_line"
    end
  end

  def travel_time_table_id
    css_class_name + "_travel_time"
  end

  def render_name( process_special_railway_line: true , prefix_ja: nil , suffix_ja: nil , prefix_en: nil , suffix_en: nil )
    h_locals = {
      this: self ,
      process_special_railway_line: process_special_railway_line ,
      prefix_ja: prefix_ja ,
      suffix_ja: suffix_ja ,
      prefix_en: prefix_en ,
      suffix_en: suffix_en
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :text }<
  = this.render_name_base( process_special_railway_line: true , prefix_ja: prefix_ja , suffix_ja: suffix_ja , prefix_en: prefix_en , suffix_en: suffix_en )
    HAML
  end

  def render_name_base( process_special_railway_line: true , prefix_ja: nil , suffix_ja: nil , prefix_en: nil , suffix_en: nil )
    h_locals = {
      text_ja_ary: name_ja_with_operator_name( process_special_railway_line: process_special_railway_line , prefix: prefix_ja , suffix: suffix_ja ).split( / \/ / ) ,
      text_en_ary: name_en_with_operator_name( process_special_railway_line: process_special_railway_line , prefix: prefix_en , suffix: suffix_en ).split( / \/ / )
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- text_ja_ary.each do | str |
  %p{ class: :text_ja }<
    = str
- text_en_ary.each do | str |
  %p{ class: :text_en }<
    = str
    HAML
  end


  def render_simple_title
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :title_of_a_railway_line }
  %h3{ class: :text_ja }<
    = this.name_ja
  %h4{ class: :text_en }<
    = this.name_en
    HAML
  end

  alias :render_title_in_train_location :render_simple_title
  alias :render_title_in_women_only_car_info :render_simple_title

  # @!endgroup

  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :railway_line }<
  %span{ class: :text_ja }<
    = this.name_ja
  %span{ class: :text_en }<
    = this.name_en
    HAML
  end

  def render_travel_time_simple_infos
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- this.travel_time_infos.each do | travel_time_info |
  = travel_time_info.decorate.render_simple_info
    HAML
  end

  def render_in_pages_related_to_station
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
= this.render_railway_line_code( must_display_line_color: true , small: true )
= this.render_name( process_special_railway_line: true )
    HAML
  end

  alias :render_in_station_info_of_travel_time_info :render_in_pages_related_to_station

  def render_connecting_railway_line_info_in_station_facility
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: this.css_class_name_of_connecting_railway_line }<
  = this.render_link_to_railway_line_page
    HAML
  end

  def render_railway_line_code( must_display_line_color: true , small: false )
    h_locals = {
      letter: railway_line_code_letter ,
      must_display_line_color: must_display_line_color ,
      class_name: css_class_name_of_railway_line_code( small ) ,
      small: small
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if letter.present?
  %div{ class: class_name }<
    %p<
      = letter
- elsif must_display_line_color
  = ::TokyoMetro::App::Renderer::ColorBox.new( request , size: :small ).render
- else
  %div{ class: class_name }<
    HAML
  end

  def render_railway_line_code_with_outer_domain
    if name_code.present?
      h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :railway_line_code_outer }
  = this.render_railway_line_code
      HAML
    end
  end

  def render_matrix( make_link_to_railway_line: true , link_controller_name: nil , size: :normal )
    raise "Error" if !( make_link_to_railway_line ) and link_controller_name.present?
    case size
    when :normal
      class_names = [ :railway_line_matrix , :each_line , css_class_name ]
    when :small
      class_names = [ :railway_line_matrix_small , :each_line , css_class_name ]
    end

    h_locals = {
      this: self ,
      make_link_to_railway_line: make_link_to_railway_line ,
      link_controller_name: link_controller_name ,
      size: size ,
      class_names: class_names
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_names }
  - if make_link_to_railway_line
    - if link_controller_name.present?
      - url = url_for( controller: link_controller_name , action: this.railway_line_page_name )
    - else
      - url = url_for( action: this.railway_line_page_name )
    = link_to_unless_current( "" , url )
  - case size
  - when :normal
    %div{ class: :info }
      = this.render_railway_line_code_with_outer_domain
      = this.render_name_base( process_special_railway_line: true )
  - when :small
    %div{ class: :info }
      = this.render_railway_line_code_with_outer_domain
      = this.render_name( process_special_railway_line: true )
    HAML
  end

  def render_matrix_and_links_to_stations( make_link_to_railway_line , type_of_link_to_station , set_anchor )
    @type_of_link_to_station = type_of_link_to_station
    h_locals = {
      this: self ,
      make_link_to_railway_line: make_link_to_railway_line ,
      set_anchor: set_anchor
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :railway_line }
  = this.render_matrix( make_link_to_railway_line: make_link_to_railway_line , size: :small )
  - case this.same_as
  - when "odpt.Railway:TokyoMetro.Marunouchi"
    = this.render_matrix_and_links_to_stations_of_railway_line_including_branch( ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" ) , set_anchor )
  - when "odpt.Railway:TokyoMetro.Chiyoda"
    = this.render_matrix_and_links_to_stations_of_railway_line_including_branch( ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" ) , set_anchor )
  - else
    %div{ class: :stations }
      = this.render_matrix_and_links_to_stations_of_normal_railway_line( set_anchor: set_anchor )
    HAML
  end

  # 通常の路線の駅一覧を書き出す
  def render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: @type_of_link_to_station , set_anchor: set_anchor )
    h_locals = {
      this: self ,
      type_of_link_to_station: type_of_link_to_station ,
      set_anchor: set_anchor
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- this.station_infos.each do | station_info |
  = station_info.decorate.render_link_to_station_in_matrix( type_of_link_to_station , set_anchor: set_anchor )
    HAML
  end

  # 支線を含む路線の駅一覧を書き出す
  def render_matrix_and_links_to_stations_of_railway_line_including_branch( branch_line , set_anchor )
    h_locals = {
      this: self , branch_line: branch_line ,
      type_of_link_to_station: @type_of_link_to_station ,
      set_anchor: set_anchor
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :stations_on_main_line }
  = this.render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: type_of_link_to_station , set_anchor: set_anchor )
%div{ class: :stations_on_branch_line }
  = branch_line.decorate.render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: type_of_link_to_station , set_anchor: set_anchor )
    HAML
  end

  def render_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: [ :document_info_box_normal , this.css_class_name ] }
  %div{ class: :top }
    = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
    = this.render_railway_line_code( must_display_line_color: false )
    = this.render_color_info_in_document
  %div{ class: :railway_line_name }
    = this.render_name_ja_in_document_info_box
    = this.render_name_en_in_document_info_box
    HAML
  end

  def render_color_info_in_document
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :color_info }
  %div{ class: :web_color }<
    = this.color
  - if this.color.present?
    %div{ class: :rgb_color }<
      = ::ApplicationHelper.rgb_in_parentheses( this.color )
    HAML
  end

  def render_name_ja_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- regexp = ::ApplicationHelper.regexp_for_parentheses_normal
- railway_line_name_ja = this.name_ja_with_operator_name_precise
%div{ class: :text_ja }<
  - if regexp =~ railway_line_name_ja
    - out_of_parentheses = railway_line_name_ja.gsub( regexp , "" )
    - in_parentheses =  $1
    %div{ class: :main }<
      = out_of_parentheses
    %div{ class: :sub }<
      = in_parentheses
  - else
    = railway_line_name_ja
    HAML
  end

  def render_name_en_in_document_info_box
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- regexp = ApplicationHelper.regexp_for_parentheses_normal
- railway_line_name_en = this.name_en_with_operator_name_precise
%div{ class: :text_en }<
  - if regexp =~ railway_line_name_en
    - out_of_parentheses = railway_line_name_en.gsub( regexp , "" )
    - in_parentheses =  $1
    %div{ class: :main }<
      = out_of_parentheses
    %div{ class: :sub }<
      = in_parentheses
  - else
    = railway_line_name_en
    HAML
  end

  def render_link_to_railway_line_page(
    small_railway_line_code: true ,
    add_connection_info_to_class: false , station_info: nil ,
    prefix_ja: nil , prefix_en: nil , suffix_ja: nil , suffix_en: nil ,
    additional_class_of_li: nil ,
    link_type: :railway_line_page_under_action_for_station ,
    controller: nil ,
    survey_years: nil
  )
    raise "Error" if add_connection_info_to_class and station_info.blank?
    raise "Error" if !( add_connection_info_to_class ) and station_info.present?
    raise "Error" if controller.blank?
    raise "Error" if controller == :passenger_survey and survey_years.blank?
    raise "Error" if controller != :passenger_survey and survey_years.present?

    h_locals = {
      this: self ,
      small_railway_line_code: small_railway_line_code ,
      add_connection_info_to_class: add_connection_info_to_class ,
      station_info: station_info ,
      prefix_ja: prefix_ja ,
      prefix_en: prefix_en ,
      suffix_ja: suffix_ja ,
      suffix_en: suffix_en ,
      additional_class_of_li: additional_class_of_li ,
      link_type: link_type ,
      controller: controller ,
      survey_years: survey_years
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals

- li_classes = [ :railway_line , :small , this.css_class_name ]
- div_classes = [ :link_to_railway_line_page ]

- if add_connection_info_to_class and station_info.connected_to?( this.object , only_tokyo_metro: true )
  - li_classes << :this_station

- if additional_class_of_li.present?
  - li_classes << additional_class_of_li

- if current_page?( railway_line: this.css_class_name.to_s + "_line" )
  - li_classes << :this_page

- unless controller == :passenger_survey

  - case link_type
  - when :railway_line_page_under_action_for_station
    - url = url_for( railway_line: this.railway_line_page_name )
  - when :action_for_station
    - url = url_for( action: this.railway_line_page_name )
  
  %li{ class: li_classes }
    = link_to_unless_current( "" , url )
    %div{ class: div_classes }
      = this.render_railway_line_code( small: small_railway_line_code )
      = this.render_name( prefix_ja: prefix_ja , prefix_en: prefix_en , suffix_ja: suffix_ja , suffix_en: suffix_en )

- else
  %ul{ class: [ :each_railway_line , this.css_class_name ] }
    %li{ class: li_classes - [ this.css_class_name ] }
      = link_to_unless_current( "" , url_for( controller: controller , action: :action_for_railway_line_or_year_page , railway_line: this.railway_line_page_name ) )
      %div{ class: div_classes }
        = this.render_railway_line_code( small: small_railway_line_code )
        = this.render_name( prefix_ja: prefix_ja , prefix_en: prefix_en , suffix_ja: suffix_ja , suffix_en: suffix_en )
    - survey_years.each do | survey_year |
      %li{ class: :survey_year }
        = link_to_unless_current( "" , url_for( controller: controller , action: :action_for_railway_line_or_year_page , railway_line: this.railway_line_page_name , survey_year: survey_year ) )
        %p{ class: :text_en }<
          = survey_year
    HAML
  end
  
  def render_link_to_railway_line_page_of_fare( station_info )
    render_link_to_railway_line_page(
      small_railway_line_code: true ,
      station_info: station_info , add_connection_info_to_class: true ,
      suffix_ja: "の各駅まで" , prefix_en: "To stations / on" ,
      link_type: :railway_line_page_under_action_for_station ,
      controller: :fare
    )
  end
  
  def render_link_to_railway_line_page_of_passenger_survey( survey_years , additional_class_of_li: nil )
    render_link_to_railway_line_page(
      small_railway_line_code: true ,
      suffix_ja: "の各駅" , prefix_en: "Stations on" ,
      additional_class_of_li: additional_class_of_li ,
      link_type: :action_for_station ,
      controller: :passenger_survey ,
      survey_years: survey_years
    )
  end

  private

  def railway_line_code_letter
    if name_code.instance_of?( ::String )
      name_code
    else
      nil
    end
  end

  def css_class_name_of_railway_line_code( small )
    if small
      :railway_line_code_32
    else
      :railway_line_code_48
    end
  end

  def railway_line_decorated
    self
  end

  def railway_line_page_exists?
    object.tokyo_metro?
  end

  def set_anchor_in_travel_time_info_table?
    object.branch_line?
  end

end