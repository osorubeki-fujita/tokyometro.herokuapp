module CommonTitleHelper

  #extend ActiveSupport::Concern

  #module ClassMethods
  
  # class << self

  def render_top_title( text_ja: common_title_ja , text_en: common_title_en , id: nil )
    h_locals = {
      text_ja: text_ja ,
      text_en: text_en ,
      id: id
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
- if id.present?
  %div{ id: id }
    = render_common_title( text_ja: text_ja , text_en: text_en )
    = render_top
- else
  = render_common_title( text_ja: text_ja , text_en: text_en )
  = render_top
    HAML
  end

  def render_common_title( text_ja: common_title_ja , text_en: common_title_en )
    h_locals = {
      text_ja: text_ja ,
      text_en: text_en ,
      h1_class_name: top_title_class_name( text_ja )
    }
    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :common }
  %h1{ class: h1_class_name }<
    = text_ja
  %h2{ class: :text_en }<
    = text_en
      HAML
  end

  def render_top
    render inline: <<-HAML , type: :haml
%div{ class: :main_text }
  %div{ class: :normal }
    %h2{ class: :text_en }<
      = "Top"
      HAML
    end

  private

  def top_title_class_name( text_ja )
    if /\A[a-zA-Z ]+\Z/ =~ text_ja
      :text_en
    else
      :text_ja
    end
  end

  # end

end