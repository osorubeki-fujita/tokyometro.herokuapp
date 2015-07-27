class Railway::Line::InfoDecorator < Draper::Decorator
  delegate_all

  include CommonTitleRenderer
  include TwitterRenderer

  [ :in_station_timetable , :in_platform_transfer_info , :in_document , :title , :matrix , :code_domain ].each do | method_name |
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

  def name_ja_to_display( process_special_railway_line: true , prefix: nil , suffix: nil )
    str = super( process_special_railway_line: process_special_railway_line )

    if prefix.present?
      str = prefix + str
    end

    if suffix.present?
      str += suffix
    end

    return str
  end

  def name_en_to_display( process_special_railway_line: true , prefix: nil , suffix: nil )
    str = super( process_special_railway_line: process_special_railway_line )

    if prefix.present?
      str = "#{ prefix } #{ str }"
    end

    if suffix.present?
      str = "#{ str } #{ suffix }"
    end

    return str
  end

  def render_name( process_special_railway_line: true , prefix_ja: nil , suffix_ja: nil , prefix_en: nil , suffix_en: nil , clearfix: false )
    div_classes = [ :text ]
    if clearfix
      div_classes << :clearfix
    end

    h_locals = {
      this: self ,
      div_classes: div_classes ,
      text_ja_ary: name_ja_to_display( process_special_railway_line: process_special_railway_line , prefix: prefix_ja , suffix: suffix_ja ).split( / \/ / ) ,
      text_en_ary: name_en_to_display( process_special_railway_line: process_special_railway_line , prefix: prefix_en , suffix: suffix_en ).split( / \/ / )
    }

    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: div_classes }<
  - text_ja_ary.each do | str |
    %p{ class: :text_ja }<
      = str
  - text_en_ary.each do | str |
    %p{ class: :text_en }<
      = str
    HAML
  end

  # @!endgroup

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
    if object.operator_info.tokyo_metro?
      "Twitter #{ object.name_ja } 運行情報"
    else
      nil
    end
  end

  def render_travel_time_simple_infos
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- this.travel_time_infos.each do | travel_time_info |
  = travel_time_info.decorate.render_simple_info
    HAML
  end


  def self.render_travel_time_simple_infos_of_multiple_railway_line_infos( railway_line_infos )
    h.render inline: <<-HAML , type: :haml , locals: { infos: railway_line_infos }
- infos.each do | railway_line_info |
  %div{ class: :railway_line }
    = railway_line_info.decorate.render_travel_time_simple_infos
    HAML
  end

=begin
  def code
    raise
  end

  def code_info
    raise
    if code_normal.string?
      code_normal
    else
      nil
    end
  end
=end

  private

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
