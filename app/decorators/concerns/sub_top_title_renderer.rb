module SubTopTitleRenderer

  def render_sub_top_title( text_ja: sub_top_title_ja , text_en: sub_top_title_en )
    h.render inline: <<-HAML , type: :haml , locals: { text_ja: text_ja , text_en: text_en }
%div{ class: :top_title }<
  %h2{ class: :text_ja }<>
    = text_ja
  %h3{ class: :text_en }<>
    = text_en
      HAML
  end

end