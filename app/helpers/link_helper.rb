module LinkHelper

  def link_to_tokyo_metro_official( class_name: :link )
    link_to_other_website( "東京メトロ Official" , "http://www.tokyometro.jp/index.html" )
  end

  def link_to_top_of_opendata_contest( class_name: :link )
    link_to_other_website( "オープンデータ活用コンテスト 概要" , "http://tokyometro10th.jp/future/opendata/index.html" , class_name: [ class_name , :small ].flatten )
  end

  def link_to_top_for_developer( class_name: :link )
    link_to_other_website( "コンテスト公式 開発者向けサイト" , "https://developer.tokyometroapp.jp/" , class_name: [ class_name , :small ].flatten )
  end

  def link_to_document( class_name: :link )
    link_to_document_pages( "開発ドキュメント" , "/document/index" , class_name: class_name )
  end

  def link_to_how_to_use( class_name: :link )
    link_to_document_pages( "マニュアル・開発者より" , "/document/how_to_use" , class_name: class_name )
  end

  def link_to_disclaimer( class_name: :link )
    link_to_document_pages( "免責事項" , "/application/disclaimer" , class_name: class_name )
  end

  def link_to_remark( class_name: :link )
    link_to_document_pages( "ご利用上の注意" , "/application/remark" , class_name: class_name )
  end

  private

  def link_to_other_website( title , url , class_name: :link , target: :_blank )
    h_locals = { title: title , url: url , class_name: class_name , target: target }
    render inline: <<-HAML , type: :haml , locals: h_locals
%li<
  = link_to( "" , url , only_path_setting: false , class: class_name , target: target )
  %div{ class: :link_to_other_website }<
    = title
    HAML
  end

  def link_to_document_pages( title , url , class_name: :link )
    h_locals = { title: title , url: url , class_name: class_name }
    render inline: <<-HAML , type: :haml , locals: h_locals
%li<
  = link_to_unless_current( "" , url , only_path_setting: false , class: class_name )
  %div{ class: :link_to_document_page }<
    = title
    HAML
  end

end