module DocumentHelper

  def document_top_title
    render inline: <<-HAML , type: :haml
%div{ id: :document_title }
  = document_common_title
  = application_common_top_title
    HAML
  end

  def document_title_of_each_content( title_ja , title_en )
    render inline: <<-HAML , type: :haml , locals: { title_ja: title_ja , title_en: title_en }
%div{ id: :document_title }
  = document_common_title
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

  def self.train_type_css_class_in_document( train_type )
    train_type.same_as.gsub( train_type_regexp , "" ).gsub( /\./ , "_" ).underscore
  end

  private

  def document_common_title
    title_of_main_contents( document_common_title_ja , document_common_title_en )
  end

  def document_common_title_ja
    "ドキュメント"
    # "開発ドキュメント"
  end

  def document_common_title_en
    "Documents"
    # "Documents of development"
  end

  class << self

    private

    def train_type_regexp
      /\Acustom\.TrainType\:(?:[a-zA-Z]+)\.(?:[a-zA-Z]+)\./
    end

  end

end