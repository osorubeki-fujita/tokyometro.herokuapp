class TokyoMetro::App::Renderer::Concern::Header::Title::SubContent < TokyoMetro::App::Renderer::Concern::Header::Title::MetaClass

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :main_text }
  %div{ class: :normal }
    %h2{ class: :text_ja }<
      = text_ja
    %h3{ class: :text_en }<
      = text_en
    HAML
  end

end