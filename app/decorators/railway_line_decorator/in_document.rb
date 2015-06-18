class RailwayLineDecorator::InDocument < TokyoMetro::Factory::Decorate::AppSubDecorator::InDocument

  def render
    h.render inline: <<-HAML , type: :haml , locals: { this: self }
%li{ class: [ :document_info_box , this.css_class_name , :clearfix ] }
  = this.render_main_domain
  = this.render_button_domain
  = this.render_infos
    HAML
  end

  def render_main_domain
    h.render inline: <<-HAML , type: :haml , locals: { this: self , number: object.id }
%div{ class: :main }
  %div{ class: [ :number , :text_en ] }<
    = number
  = ::TokyoMetro::App::Renderer::ColorBox.new( request ).render
  = this.decorator.render_railway_line_code( must_display_line_color: false )
  %div{ class: :railway_line_name }
    = this.render_name_ja
    = this.render_name_en
  = this.render_color_info
    HAML
  end

  def render_color_info
    h.render inline: <<-HAML , type: :haml , locals: { color: object.color }
%div{ class: :color_info }
  %div{ class: [ :web_color , :text_en ] }<
    = color
  - if color.present?
    %div{ class: [ :rgb_color , :text_en ] }<
      = color.to_rgb_color_in_parentheses
    HAML
  end

  def render_name_ja
    regexp = ::PositiveStringSupport::RegexpLibrary.regexp_for_parentheses_ja ,
    name_ja = name_ja_with_operator_name_precise

    if regexp =~ name_ja
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

end

__END__

  def infos_to_render
    super().merge({
      "Infos from Db columns of station info object" => infos_from_db_columns_of_station_info_object ,
      "Infos from Db columns of railway line object" => infos_from_db_columns_of_railway_line_object
    })
  end

  def infos_from_db_columns_of_station_info_object
    infos_from_methods_of( object.station_info , :same_as )
  end

  def infos_from_db_columns_of_railway_line_object
    infos_from_methods_of( object.railway_line , :same_as )
  end

  def infos_from_db_columns_of_operator_object
    infors_from_db_columns_of( object.operator )
  end
  
  def infos_from_methods_of_operator_object
    infos_from_methods_of( object.operator , :name_ja_normal , :name_en_normal )
  end
  
  def infos_from_methods_of_operator_decorator
    infos_from_methods_of( object.operator.decorate , :twitter_title )
  end
  