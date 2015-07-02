module SubTitleRenderer

  def render_sub_title
    h.render inline: <<-HAML , type: :haml , locals: { text_ja: sub_title_ja , text_en: sub_title_en , class_of_sub_title: class_of_sub_title }
%div{ class: [ class_of_sub_title , :text_ja ] }<
  != text_ja
  %span{ class: :text_en }<
    = text_en
    HAML
  end

  private

  def class_of_sub_title
    :title
  end

end
