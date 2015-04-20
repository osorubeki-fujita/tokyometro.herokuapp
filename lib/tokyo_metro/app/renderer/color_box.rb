class TokyoMetro::App::Renderer::ColorBox < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , class_name: nil , size: :normal , text: text )
    super( request )
    @class_name = set_class_name( class_name , size )
    @text = text
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_name }<
  - if text.present?
    = text
    HAML
  end

  private

  def h_locals
    super.merge({
      class_name: @class_name ,
      text: @text
    })
  end

  def set_class_name( class_name , size )
    if class_name.present?
      class_name
    else
      case size
      when :normal
        :color_box_48
      when :small
        :color_box_32
      else
        raise "Error: The size \'#{ size }\' is not valid."
      end
    end
  end

end