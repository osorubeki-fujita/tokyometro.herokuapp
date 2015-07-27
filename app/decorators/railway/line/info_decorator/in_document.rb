class Railway::Line::InfoDecorator::InDocument < TokyoMetro::Factory::Decorate::SubDecorator::InDocument

  include ::TokyoMetro::Factory::Decorate::SubDecorator::InDocument::ColorInfo

  # @!group Main methods

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , li_classes: li_classes }
%li{ class: li_classes }
  = this.render_id_and_size_changing_buttons
  = this.render_main_domain
  = this.render_infos
    HAML
  end

  def render_title
    h.render inline: <<-HAML , type: :haml , locals: h_object
%div{ class: :railway_line_name }
  %h4{ class: :text_ja }<
    = o.name_ja
  %h5{ class: :text_en }<
    = o.name_en
  %h5{ class: [ :text_en , :same_as ] }<
    = "same_as: "+ o.same_as
    HAML
  end

  # @!group Sub public methods

  def render_main_domain
    h.render inline: <<-HAML , type: :haml , locals: h_this
%div{ class: [ :main , :clearfix ] }
  = this.render_color_box_and_code
  %div{ class: :railway_line_name }
    = this.render_name_ja
    = this.render_name_en
    %p{ class: [ :same_as , :text_en ] }<
      = this.object.same_as
  = this.render_color_info
    HAML
  end

  def render_color_box_and_code
    h_locals_i = h_this.merge( { request: request } )

    if has_many_code_infos?
      h.render inline: <<-HAML , type: :haml , locals: h_locals_i
%div{ class: [ :multiple_codes , :clearfix ] }
  - 1.upto( this.object.code_infos.length ) do |i|
    %div{ class: [ this.object.css_class(i) , :clearfix ] }
      = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
      = this.decorator.code_domain.render( i , must_display_line_color: false )
      HAML

    else
      h.render inline: <<-HAML , type: :haml , locals: h_locals_i
= ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
= this.decorator.code_domain.render( must_display_line_color: false )
      HAML

    end
  end

  def render_name_ja
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_ja
    name_ja = object.name_ja_with_operator_name_precise

    if name_ja.present? and regexp =~ name_ja
      h_locals = {
        out_of_parentheses: name_ja.gsub( regexp , "" ) ,
        in_parentheses: $1
      }

      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :text_ja }<
  %p{ class: :text_ja_main }<
    = out_of_parentheses
  %p{ class: :text_ja_sub }<
    = in_parentheses
      HAML

    else
      h.content_tag( :p , name_ja , class: :text_ja )
    end
  end

  def render_name_en
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_en
    _name_en = object.name_en_with_operator_name_precise

    if regexp =~ _name_en
      h_locals = {
        out_of_parentheses: _name_en.gsub( regexp , "" ) ,
        in_parentheses: $1
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :text_en }<
  %p{ class: :text_en_main }<
    = out_of_parentheses
  %p{ class: :text_en_sub }<
    = in_parentheses
      HAML

    else
      h.content_tag( :p , _name_en , class: :text_en )
    end
  end

  private

  def has_many_code_infos?
    object.send( __method__ )
  end

  def li_classes
    ary = ::Array.new
    ary << :document_info_box
    unless has_many_code_infos?
      ary << object.css_class
    end
    ary << :clearfix

    return ary
  end

  def infos_to_render
    super().merge({
      "Infos from methods of railway line object" => infos_from_methods_of_railway_line_info_object ,
      "Infos from db columns of operator object (partial)" => infos_from_db_columns_of_operator_object ,
      "Infos from db columns of railway line decorator (partial)" => infos_from_methods_of_railway_line_decorator ,
      "Infos from db columns of railway line decorator in platform transfer info (partial)" => infos_from_methods_of_railway_line_decorator_in_platform_transfer_info
    }).merge(
      h_for_infos_from_db_columns_of_additional_infos_object
    )
  end

  def infos_from_methods_of_railway_line_info_object
    h1 = infos_from_methods_of_object(
      :name_ja_normal ,
      :name_ja_with_operator_name ,
      :name_ja_with_operator_name_precise ,
      :name_en_normal ,
      :name_en_with_operator_name ,
      :name_en_with_operator_name_precise
    )

    h2 = { "name_ja_with_operator_name_precise( without_parentheses: true )" => object.name_ja_with_operator_name_precise( without_parentheses: true ) }

    h3 = infos_from_methods_of_object(
      :name_ja_to_display ,
      :name_en_to_display
    )

    h4 = infos_from_methods_of_object(
      :css_class ,
      :station_attribute_ja ,
      :station_attribute_hira ,
      :station_attribute_en ,
      :station_attribute_en_short ,
      :tokyo_metro? ,
      :on_jr_lines? ,
      :on_toden_arakawa_line? ,
      :tobu_skytree_line? ,
      :seibu_yurakucho_line?
    )

    h1.merge(h2).merge(h3).merge(h4)
  end

  def infos_from_db_columns_of_operator_object
    infos_from_methods_of( object.operator_info , :same_as )
  end

  def infos_from_methods_of_railway_line_decorator
    infos_from_methods_of_decorator(
      :twitter_title ,
      :page_name ,
      :travel_time_table_id
    )
  end

  def infos_from_methods_of_railway_line_decorator_in_platform_transfer_info
    d = decorator.in_platform_transfer_info
    {
      "name_ja (private)" => d.send( :name_ja ) ,
      "name_en (private)" => d.send( :name_en )
    }
  end

  def h_for_infos_from_db_columns_of_additional_infos_object
    infos_from_db_columns_of_multiple( object.additional_infos , "Infos from db columns of Railway::Line::AdditionalInfo object" )
  end

end
