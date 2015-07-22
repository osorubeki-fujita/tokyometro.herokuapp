class Railway::Line::InfoDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer
  include TwitterRenderer

  [ :in_station_timetable , :in_platform_transfer_info , :in_document , :title , :matrix , :code ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        ::Railway::Line::InfoDecorator::#{ method_name.camelize }.new( self )
      end
    DEF
  end

  def self.common_title_ja
    "路線のご案内"
  end

  def self.common_title_en
    "Information of railway lines"
  end

  def self.render_travel_time_simple_infos_of_multiple_railway_line_infos( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
- infos.each do | railway_line_info |
  %div{ class: :railway_line }
    = railway_line_info.decorate.render_travel_time_simple_infos
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

    return str
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

    return str
  end

  def page_name
    if object.branch_line?
      "#{ css_class }_line".gsub( /_branch/ , "" )
    else
      "#{ css_class }_line"
    end
  end

  def travel_time_table_id
    "#{ css_class }_travel_time"
  end

  def twitter_title
    if object.operator.tokyo_metro?
      "Twitter #{ object.name_ja } 運行情報"
    else
      nil
    end
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

  # @!endgroup

  def render_travel_time_simple_infos
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- this.travel_time_infos.each do | travel_time_info |
  = travel_time_info.decorate.render_simple_info
    HAML
  end

  private

  def railway_line_code_letter
    if name_code_normal.string?
      name_code_normal
    else
      nil
    end
  end

  def css_class_of_railway_line_code( small , clearfix )
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
