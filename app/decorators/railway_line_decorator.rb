class RailwayLineDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer
  include TwitterRenderer

  def self.common_title_ja
    "路線のご案内"
  end

  def self.common_title_en
    "Information of railway lines"
  end

  # タイトルのメイン部分（路線色・路線名）を記述するメソッド
  def self.name_main( railway_lines , survey_year: nil )
    railway_lines = [ railway_lines ].flatten
    class << railway_lines
      include ::TokyoMetro::TempLib::RailwayLineArrayModule
    end

    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines , survey_year: survey_year }
%div{ class: :main_text }
  - # タイトルの路線名を記述
  %div{ class: [ infos.to_title_color_class , :railway_line ] }
    %h2{ class: :text_ja }<
      = infos.to_railway_line_name_text_ja
    %h3{ class: :text_en }<
      = infos.to_railway_line_name_text_en
  - if survey_year.present?
    %div{ class: [ :survey_year , :text_en ] }<
      = survey_year
    HAML
  end

  def self.render_title_of_railway_lines( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :railway_line_title }
  = ::RailwayLineDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  # タイトルを記述するメソッド（路線別）
  def self.render_title_of_passenger_survey( railway_lines , survey_year )
    h_locals = { infos: railway_lines , survey_year: survey_year }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :passenger_survey_title }
  = ::PassengerSurveyDecorator.render_common_title( request , :railway_line )
  = ::RailwayLineDecorator.name_main( infos , survey_year: survey_year )
    HAML
  end

  def self.render_title_of_station_facility( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_lines }
%div{ id: :station_facility_title }
  = ::StationFacility::InfoDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( infos )
    HAML
  end

  # 列車運行情報のタイトルを記述するメソッド
  def self.render_title_of_train_operation_info( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
%div{ id: :train_operation_info_title }
  = ::TrainOperation::InfoDecorator.render_common_title( request )
  = ::RailwayLineDecorator.name_main( railway_lines )
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
  = ::TokyoMetro::App::Renderer::Concerns::Header::Title::Base.new( request , ::RailwayTimetableHelper.common_title_ja , ::RailwayTimetableHelper.common_title_en ).render
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
%div{ id: :railway_line_matrixes , class: :clearfix }
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
    if process_special_railway_line and seibu_yurakucho_line?
      str = "西武線"
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
    if process_special_railway_line and seibu_yurakucho_line?
      str = "Seibu Line"
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

  def railway_line_page_name
    if object.branch_line?
      "#{ css_class_name }_line".gsub( /_branch/ , "" )
    else
      "#{ css_class_name }_line"
    end
  end

  alias :page_name :railway_line_page_name

  def travel_time_table_id
    "#{ css_class_name }_travel_time"
  end

  def render_name( process_special_railway_line: true , prefix_ja: nil , suffix_ja: nil , prefix_en: nil , suffix_en: nil , clearfix: false )
    div_classes = [ :text ]
    if clearfix
      div_classes << :clearfix
    end
    h_locals = {
      this: self ,
      process_special_railway_line: process_special_railway_line ,
      prefix_ja: prefix_ja ,
      suffix_ja: suffix_ja ,
      prefix_en: prefix_en ,
      suffix_en: suffix_en ,
      div_classes: div_classes
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: div_classes }<
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

  def render_railway_line_code( must_display_line_color: true , small: false , clearfix: false )
    if railway_line_code_letter.present?
      h_locals = {
        letter: railway_line_code_letter ,
        class_name: css_class_name_of_railway_line_code( small , clearfix )
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_name }<
  %p<
    = letter
      HAML
    elsif must_display_line_color
      if small
        size = :small
      else
        size = :normal
      end
      ::TokyoMetro::App::Renderer::ColorBox.new( h.request , size: size ).render
    else
      puts object.same_as
      h.render inline: <<-HAML , type: :haml , locals: { class_name: css_class_name_of_railway_line_code( small , clearfix ) }
%div{ class: class_name }<
      HAML
    end
  end

  def render_railway_line_code_with_outer_domain( must_display_line_color: true , small: false , clearfix: false )
    if must_display_line_color or name_code.present?
      if small
        div_classes = [ :railway_line_code_outer_small ]
      else
        div_classes = [ :railway_line_code_outer ]
      end
      h_locals = {
        this: self ,
        must_display_line_color: must_display_line_color ,
        small: small ,
        clearfix: clearfix  ,
        div_classes: div_classes
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: div_classes }
  = this.render_railway_line_code( must_display_line_color: must_display_line_color , small: small , clearfix: clearfix )
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
    when :very_small
      class_names = [ :railway_line_matrix_very_small , :each_line , css_class_name ]
    else
      raise "Error: size settings \' :#{ size } \' is not valid."
    end

    url = nil

    if make_link_to_railway_line
      if link_controller_name.present?
        url = h.url_for( controller: link_controller_name , action: :action_for_railway_line_page , railway_line: railway_line_page_name )
      else
        url = h.url_for( action: railway_line_page_name )
      end
    end

    h_locals = {
      this: self ,
      class_names: class_names ,
      make_link_to_railway_line: make_link_to_railway_line ,
      url: url ,
      small_railway_line_code: ( size == :very_small )
    }

    case size
    when :normal , :small , :very_small
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_names }
  - if make_link_to_railway_line
    = link_to_unless_current( "" , url )
  %div{ class: [ :info , :clearfix ] }
    = this.render_railway_line_code_with_outer_domain( small: small_railway_line_code )
    = this.render_name( process_special_railway_line: true )
      HAML
    end
  end

  def render_matrix_and_links_to_stations( make_link_to_railway_line , type_of_link_to_station , set_anchor )
    @type_of_link_to_station = type_of_link_to_station
    h_locals = {
      this: self ,
      make_link_to_railway_line: make_link_to_railway_line ,
      set_anchor: set_anchor
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ :railway_line , :clearfix ] }
  = this.render_matrix( make_link_to_railway_line: make_link_to_railway_line , size: :small )
  - case this.same_as
  - when "odpt.Railway:TokyoMetro.Marunouchi"
    = this.render_matrix_and_links_to_stations_of_railway_line_including_branch( ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" ) , set_anchor )
  - when "odpt.Railway:TokyoMetro.Chiyoda"
    = this.render_matrix_and_links_to_stations_of_railway_line_including_branch( ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.ChiyodaBranch" ) , set_anchor )
  - else
    %ul{ class: [ :stations , :text_ja , :clearfix ] }
      = this.render_matrix_and_links_to_stations_of_normal_railway_line( set_anchor: set_anchor )
    HAML
  end

  # 通常の路線の駅一覧を書き出す
  def render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: @type_of_link_to_station , set_anchor: set_anchor )
    h_locals = {
      station_infos: station_infos ,
      type_of_link_to_station: type_of_link_to_station ,
      set_anchor: set_anchor
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- station_infos.each do | station_info |
  = station_info.decorate.render_link_to_station_in_matrix( type_of_link_to_station , set_anchor: set_anchor )
    HAML
  end

  # 支線を含む路線の駅一覧を書き出す
  def render_matrix_and_links_to_stations_of_railway_line_including_branch( branch_line , set_anchor )
    h_locals = {
      this: self ,
      branch_line: branch_line ,
      type_of_link_to_station: @type_of_link_to_station ,
      set_anchor: set_anchor
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%ul{ class: [ :stations_on_main_line , :text_ja , :clearfix ] }
  = this.render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: type_of_link_to_station , set_anchor: set_anchor )
%ul{ class: [ :stations_on_branch_line , :text_ja , :clearfix ] }
  = branch_line.decorate.render_matrix_and_links_to_stations_of_normal_railway_line( type_of_link_to_station: type_of_link_to_station , set_anchor: set_anchor )
    HAML
  end

  def in_document
    ::RailwayLineDecorator::InDocument.new( self )
  end

  def in_platform_transfer_info
    ::RailwayLineDecorator::InPlatformTransferInfo.new( self )
  end

  private

  def railway_line_code_letter
    if name_code.string?
      name_code
    else
      nil
    end
  end

  def css_class_name_of_railway_line_code( small , clearfix )
    ary = ::Array.new
    if small
      ary << :railway_line_code_32
    else
      ary << :railway_line_code_48
    end
    if clearfix
      ary << :clearfix
    end
    ary
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
