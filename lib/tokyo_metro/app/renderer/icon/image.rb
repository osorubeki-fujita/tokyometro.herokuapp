class TokyoMetro::App::Renderer::Icon::Image < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , image_filename , class_name: nil )
    super( request )
    @image_filename = image_filename
    @class_name = class_name
  end

  def render
    h.image_tag( @image_filename , class: @class_name )
  end

end