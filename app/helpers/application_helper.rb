module ApplicationHelper

  # include CommonTitleHelper

  def self.tokyo_metro
    ::Operator.find_by_same_as( "odpt.Operator:TokyoMetro" )
  end

  def self.common_title_ja
    "Tokyo Metro Open Data Contest"
  end

  def self.common_title_en
    "Ruby for Rails"
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