class TokyoMetro::App::Renderer::Concern::Header::Title::Base < TokyoMetro::App::Renderer::Concern::Header::Title::MetaClass

  def render
    h.render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: domain_class_name }
  %h1{ class: h1_class_name }<
    = text_ja
  %h2{ class: :text_en }<
    = text_en
    HAML
  end

  private

  def h_locals
    super.merge({
      h1_class_name: h1_class_name
    })
  end

  def h1_class_name
    if /\A[a-zA-Z ]+\Z/ =~ @text_ja
      :text_en
    else
      :text_ja
    end
  end

end