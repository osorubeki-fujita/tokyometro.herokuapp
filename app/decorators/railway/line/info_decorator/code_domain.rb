class Railway::Line::InfoDecorator::CodeDomain < TokyoMetro::Factory::Decorate::SubDecorator

  def render( i = 0 , must_display_line_color: true , small: false , clearfix: false )
    _codes = object.codes_to_a
    if _codes.present?

      i = index_of_code( i , _codes.length )
      code = _codes[i]
      class_name =

      h.content_tag( :div , class: css_class_of_railway_line_code( small , clearfix ) ) do
        h.content_tag( :p , code )
      end

    elsif must_display_line_color
      if small
        size = :small
      else
        size = :normal
      end
      ::TokyoMetro::App::Renderer::ColorBox.new( h.request , size: size ).render
    else
      puts object.same_as
      h.content_tag( :div , "" , class: css_class_of_railway_line_code( small , clearfix ) )
    end
  end

  def render_with_outer_domain( must_display_line_color: true , small: false , clearfix: false )
    if must_display_line_color or code_normal.present?
      if small
        div_classes = [ :railway_line_code_outer_small ]
      else
        div_classes = [ :railway_line_code_outer ]
      end

      h.content_tag( :div , class: div_classes ) do
        render( must_display_line_color: must_display_line_color , small: small , clearfix: clearfix )
      end

    end
  end

  private

  def index_of_code( i , len )
    raise unless i.natural_number_including_zero?
    if i == 0
      i = 1
    end
    raise unless i <= len
    i -= 1
    return i
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

end
