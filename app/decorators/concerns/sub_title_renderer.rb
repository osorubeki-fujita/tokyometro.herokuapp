module SubTitleRenderer

  def render_sub_title
    h.render inline: <<-HAML , type: :haml , locals: { text_ja: sub_title_ja , text_en: sub_title_en }
%div{ class: [ :title , :text_ja ] }
  = text_ja
  %span{ class: :text_en }<
    = text_en
    HAML
  end

end