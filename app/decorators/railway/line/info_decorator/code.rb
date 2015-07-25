class Railway::Line::InfoDecorator::Code < TokyoMetro::Factory::Decorate::AppSubDecorator

  def render( must_display_line_color: true , small: false , clearfix: false )
    _code = decorator.code_info
    if _code.present?
      h_locals = {
        code: _code ,
        class_name: css_class_of_railway_line_code( small , clearfix )
      }
      h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_name }<
  %p<
    = code
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
      h.render inline: <<-HAML , type: :haml , locals: { class_name: css_class_of_railway_line_code( small , clearfix ) }
%div{ class: class_name }<
      HAML
    end
  end

  def render_with_outer_domain( must_display_line_color: true , small: false , clearfix: false )
    if must_display_line_color or code_normal.present?
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
  = this.code.render( must_display_line_color: must_display_line_color , small: small , clearfix: clearfix )
      HAML
    end
  end

end
