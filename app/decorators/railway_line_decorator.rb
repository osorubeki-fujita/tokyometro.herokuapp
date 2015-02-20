class RailwayLineDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer
  extend SubTopTitleRenderer

  include TwitterRenderer
  include CssClassNameOfConnectingRailwayLine

  def self.common_title_ja
    "路線のご案内"
  end

  def self.common_title_en
    "Information of railway lines"
  end

  def self.render_title_of_train_info
    render_sub_top_title( text_ja: "運行情報" , text_en: "Train information" )
  end

  def self.render_station_facility_title( railway_lines )
    render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
%div{ id: :station_facility_title }
  = ::StationFacilityDecorator.render_common_title
  = railway_line_name_main( railway_lines )
    HAML
  end

  def self.render_travel_time_simple_infos_of_multiple_railway_lines( railway_lines )
    h.render inline: <<-HAML , type: :haml , locals: { railway_lines: railway_lines }
- railway_lines.each do | railway_line |
  %div{ class: :railway_line }
    = railway_line.decorate.render_travel_time_simple_infos
    HAML
  end

  def self.render_matrixes_of_all_railway_lines( including_yurakucho_and_fukutoshin: false , make_link_to_line: true )
    h_locals = {
      including_yurakucho_and_fukutoshin: including_yurakucho_and_fukutoshin ,
      make_link_to_line: make_link_to_line
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :railway_line_matrixes }
  - ::RailwayLine.tokyo_metro.each do | railway_line |
    = railway_line.decorate.render_matrix( make_link_to_line: make_link_to_line )
  - if including_yurakucho_and_fukutoshin
    = ::RailwayLineDecorator.render_matrix_of_yurakucho_and_fukutoshin( make_link_to_line )
    HAML
  end

  def self.render_matrix_of_yurakucho_and_fukutoshin( make_link_to_line )
    h_locals = { make_link_to_line: make_link_to_line }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ :railway_line_matrix , :multiple_lines , :yurakucho_fukutoshin ] }
  - if make_link_to_line
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

  def name_ja_with_operator_name( process_special_railway_line: false )
    if process_special_railway_line
      case object.same_as
      when "odpt.Railway:Seibu.SeibuYurakucho"
        return "西武線"
      end
    end

    object.name_ja_with_operator_name
  end

  def name_en_with_operator_name( process_special_railway_line: false )
    if process_special_railway_line
      case object.same_as
      when "odpt.Railway:Seibu.SeibuYurakucho"
        return "Seibu Line"
      end
    end

    object.name_en_with_operator_name
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
    "#{ object.css_class_name }_line"
  end

  def render_name( process_special_railway_line: true )
    h.render inline: <<-HAML , type: :haml , locals: { info: self , process_special_railway_line: process_special_railway_line }
%div{ class: :text }<
  %div{ class: :text_ja }<>
    = info.name_ja_with_operator_name( process_special_railway_line: process_special_railway_line )
  %div{ class: :text_en }<>
    = info.name_en_with_operator_name( process_special_railway_line: process_special_railway_line )
    HAML
  end

  # @!group 女性専用車関連

  def render_women_only_car_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line , in_group_of_multiple_railway_line: false )
    h_locals = {
      info: self ,
      women_only_car_infos_of_a_railway_line: women_only_car_infos_of_a_railway_line ,
      in_group_of_multiple_railway_line: in_group_of_multiple_railway_line
    }
    h.render inline: <<-HAML , type: :haml , locals: h_locals
- if in_group_of_multiple_railway_line
  %div{ class: [ info.css_class_name , :in_railway_line_group ] }
    = info.render_title_in_women_only_car_info
    = render_women_only_car_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line )
- else
  %div{ class: info.css_class_name }
    = render_women_only_car_infos_in_a_railway_line( women_only_car_infos_of_a_railway_line )
    HAML
  end

  def render_title_in_women_only_car_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :title_of_a_railway_line }
  %h3{ class: :text_ja }<
    = info.name_ja
  %h4{ class: :text_en }<
    = info.name_en
    HAML
  end

  # @!endgroup

  def render_in_station_timetable_header
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :railway_line }<
  %span{ class: :text_ja }<
    = info.name_ja
  %span{ class: :text_en }<
    = info.name_en
    HAML
  end

  def render_travel_time_simple_infos
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- info.travel_time_infos.each do | travel_time_info |
  = travel_time_info.decorate.render_simple_info
    HAML
  end

  def render_in_station_info_of_travel_time_info
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
- if info.tokyo_metro?
  = link_to( "" , "../railway_line/" + info.name_en.gsub( " " , "_" ).underscore )
= info.render_railway_line_code( must_display_line_color: true , small: true )
= info.render_name( process_special_railway_line: true )
    HAML
  end
  
  def render_connecting_railway_line_info_in_station_facility
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: info.css_class_name_of_connecting_railway_line }<
  = info.render_in_station_info_of_travel_time_info
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
  = color_box( small: small )
- else
  %div{ class: class_name }<
    HAML
  end

  def render_railway_line_code_code_outer
    if name_code.present?
      h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :railway_line_code_outer }
  = info.render_railway_line_code
      HAML
    end
  end

  def render_name_in_matrix
    h.render inline: <<-HAML , type: :haml , locals: { info: self }
%div{ class: :text_ja }<
  = info.name_ja
%div{ class: :text_en }<
  = info.name_en
    HAML
  end

  def render_matrix( make_link_to_line: true , size: :normal )
    case size
    when :normal
      class_names = [ :railway_line_matrix , :each_line , railway_line.css_class_name ]
    when :small
      class_names = [ :railway_line_matrix_small , :each_line , railway_line.css_class_name ]
    end

    h_locals = {
      info: self ,
      make_link_to_line: make_link_to_line ,
      size: size ,
      class_names: class_names
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_names }
  - if make_link_to_line
    = link_to( "" , info.railway_line_page_name )
  - case size
  - when :normal
    %div{ class: :info }
      = info.render_railway_line_code_code_outer
      = info.render_name_in_matrix
  - when :small
    %div{ class: :info }
      = info.render_railway_line_code_code_outer
      %div{ class: :text }
        = info.render_name_in_matrix
    HAML
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

end