class RailwayLineDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  include ::TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument::ColorInfo

  # @!group Main methods

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self , number: object.id }
%li{ class: [ :document_info_box , this.css_class_name , :clearfix ] }
  %div{ class: [ :number , :text_en ] }<
    = number
  = this.render_main_domain
  = this.render_button_domain
  = this.render_infos
    HAML
  end

  def render_title
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
- obj = this.object
%div{ class: :railway_line_name }
  %h4{ class: :text_ja }<
    = obj.name_ja
  %h5{ class: :text_en }<
    = obj.name_en
  %h5{ class: [ :text_en , :same_as ] }<
    = "same_as: "+ obj.same_as
    HAML
  end

  # @!group Sub public methods

  def render_main_domain
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%div{ class: :main }
  = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
  = this.decorator.render_railway_line_code( must_display_line_color: false )
  %div{ class: :railway_line_name }
    = this.render_name_ja
    = this.render_name_en
    %p{ class: [ :same_as , :text_en ] }<
      = this.object.same_as
  = this.render_color_info
    HAML
  end

  def render_name_ja
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_ja
    name_ja = name_ja_with_operator_name_precise

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
      h.render inline: <<-HAML , type: :haml , locals: { name_ja: name_ja }
%p{ class: :text_ja }<
  = name_ja
      HAML
    end
  end

  def render_name_en
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_en
    name_en = name_en_with_operator_name_precise

    if regexp =~ name_en
      h_locals = {
        out_of_parentheses: name_en.gsub( regexp , "" ) ,
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
      h.render inline: <<-HAML , type: :haml , locals: { name_en: name_en }
%p{ class: :text_en }<
  = name_en
      HAML
    end
  end

  private

  def infos_to_render
    super().merge({
      "Infos from Db columns of railway line object" => infos_from_db_columns_of_railway_line_object ,
      "Infos from Db columns of operator object (partial)" => infos_from_db_columns_of_operator_object ,
      "Infos from Db columns of railway line decorator (partial)" => infos_from_methods_of_railway_line_decorator ,
      "Infos from Db columns of railway line decorator in platform transfer info (partial)" => infos_from_methods_of_railway_line_decorator_in_platform_transfer_info ,
    })
  end

  def infos_from_db_columns_of_operator_object
    infos_from_methods_of( object.operator , :same_as )
  end

  def infos_from_db_columns_of_railway_line_object
    infos_from_methods_of_object(
      :station_attribute_ja ,
      :station_attribute_hira ,
      :station_attribute_en ,
      :station_attribute_en_short ,
      :name_ja_with_operator_name_precise_and_without_parentheses ,
      :tokyo_metro? ,
      :jr_lines? ,
      :toden_arakawa_line? ,
      :tobu_sky_tree_isesaki_line? ,
      :seibu_yurakucho_line?
    )
  end

  def infos_from_methods_of_railway_line_decorator
    h1 = infos_from_methods_of_decorator(
      :name_ja_with_operator_name ,
      :name_en_with_operator_name
    )
    h2 = {
      "name_ja_with_operator_name( process_special_railway_line: true )" => name_ja_with_operator_name( process_special_railway_line: true ) ,
      "name_en_with_operator_name( process_special_railway_line: true )" => name_en_with_operator_name( process_special_railway_line: true )
    }
    h3 = infos_from_methods_of_decorator(
      :twitter_title ,
      :railway_line_page_name ,
      :page_name ,
      :travel_time_table_id
    )
    h1.merge(h2).merge(h3)
  end

  def infos_from_methods_of_railway_line_decorator_in_platform_transfer_info
    d = @decorator.in_platform_transfer_info
    {
      "name_ja (private)" => d.send( :name_ja ) ,
      "name_en (private)" => d.send( :name_en )
    }
  end

end
