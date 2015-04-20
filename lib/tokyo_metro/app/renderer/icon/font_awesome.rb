class TokyoMetro::App::Renderer::Icon::FontAwesome < TokyoMetro::App::Renderer::MetaClass

  def initialize( request , icon_name , size = 1 , rotation: nil )
    super( request )
    @icon_name = icon_name
    @size = size
    @rotation = rotation
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
= content_tag( :i , "" , class: classes )
    HAML
  end

  private

  def classes
    ary = [ :fa , "fa-#{ @icon_name }" , "fa-#{ @size }x" ]

    return ary
  end

  def h_locals
    super().merge({
      classes: classes
    })
  end

end