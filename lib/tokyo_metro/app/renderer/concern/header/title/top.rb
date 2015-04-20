class TokyoMetro::App::Renderer::Concern::Header::Title::Top < TokyoMetro::App::Renderer::MetaClass

  def initialize( request )
    super( request )
  end

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :main_text }
  %div{ class: :normal }
    %h2{ class: :text_en }<
      = "Top"
    HAML
  end

end