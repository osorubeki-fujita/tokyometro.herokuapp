module DocumentHelper

  # include CommonTitleHelper

  def self.common_title_ja
    "ドキュメント"
    # "開発ドキュメント"
  end

  def self.common_title_en
    "Documents"
    # "Documents of development"
  end

  def document_title_of_each_content( title_ja , title_en )
    render inline: <<-HAML , type: :haml , locals: { title_ja: title_ja , title_en: title_en }
%div{ id: :document_title }
  = render_common_title( text_ja: ::DocumentHelper.common_title_ja , text_en: ::DocumentHelper.common_title_en )
  = title_of_each_content( title_ja , title_en )
    HAML
  end

  def link_to_each_document_page( name_ja , name_en , url , model_name )
    render inline: <<-HAML , type: :haml , locals: { name_ja: name_ja , name_en: name_en , url: url , model_name: model_name }
%div{ class: :link_to_document_content }
  = link_to( "" , url )
  %div{ class: :text }
    %div{ class: :content_name }
      %h2{ class: :text_ja }<
        = name_ja
      %h3{ class: :text_en }<
        = name_en
    %div{ class: [ :model_name , :text_en ] }<
      = "Model: #{model_name}"
    HAML
  end

end