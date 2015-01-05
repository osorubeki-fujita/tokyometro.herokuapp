module ApplicationHelper

  def self.latest_passenger_survey_year
    2013
  end

  def title_of_main_contents( name_ja , name_en )
    if /\A[a-zA-Z ]+\Z/ =~ name_ja
      h1_class_name = :text_en
    else
     h1_class_name = :text_ja
    end
    h_locals = { name_ja: name_ja , name_en: name_en , h1_class_name: h1_class_name }
    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :common }
  %h1{ class: h1_class_name }<
    = name_ja
  %h2{ class: :text_en }<
    = name_en
    HAML
  end

  def application_common_top_title
    render inline: <<-HAML , type: :haml
%div{ class: :main_text }
  %div{ class: :normal }
    %h2{ class: :text_en }<
      = "Top"
    HAML
  end

  def title_of_each_content( name_ja , name_en )
    render inline: <<-HAML , type: :haml , locals: { name_ja: name_ja , name_en: name_en }
%div{ class: :main_text }
  %div{ class: :normal }
    %div{ class: :text_ja }
      %h2<
        = name_ja
    %div{ class: :text_en }
      %h3<
        = name_en
    HAML
  end

  def number_separated_by_comma( num )
    number_to_currency( num , unit: "" , format: "%n" , precision: 0 )
  end

  def clear_line_in_text_arr( length_of_arr , index_n )
    unless length_of_arr == index_n
      tag( :br )
    end
  end

  def self.time_strf( h , m )
    m_2 = sprintf( "%2.2d" , m)
    "#{h}:#{m_2}"
  end

  # 括弧に対する正規表現（日本語）
  # @return [Regexp]
  def self.regexp_for_parentheses_ja
    /([\(（〈\|【].+[】\|〉）\)])$/
  end

  # 機種依存文字「麴」を処理するための正規表現
  # @note 機種依存文字によるエラーを避けるためDB内に「麹町」として格納されている文字列を「麴町」に変換するために使用する。
  # @return [Regexp]
  def self.regexp_for_kouji
    /(?:麹|麴)町/
  end

  # quotation に対する正規表現
  # @return [Regexp]
  def self.regexp_for_parentheses_en
    /('.+')$/
  end

  def self.rgb_in_parentheses( web_color )
    str = web_color.to_rgb_color.join( " , " )
    "(#{str})"
  end

end