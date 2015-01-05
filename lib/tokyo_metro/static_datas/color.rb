# 鉄道事業者・路線・種別の色の情報を扱うモジュール
class TokyoMetro::StaticDatas::Color

  include ::TokyoMetro::StaticDataModules::GenerateFromHashSetVariable

  # Constructor
  # @param web [String] WebColor
  # @param red [Integer] R 成分の値
  # @param green [Integer] G 成分の値
  # @param blue [Integer] B 成分の値
  def initialize( web , red , green , blue )
    @web = web
    @red = red
    @green = green
    @blue = blue
  end

  # WebColor を取得するメソッド
  # @return [String]
  attr_reader :web
  # R 成分の値を返すメソッド
  # @return [Integer]
  attr_reader :red
  # G 成分の値を返すメソッド
  # @return [Integer]
  attr_reader :green
  # B 成分の値を返すメソッド
  # @return [Integer]
  attr_reader :blue

  alias :web_color :web

# @!group 文字列への変換

  # インスタンスの情報を文字列に変換して返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    " " * indent + "#{@web} (#{ self.to_a_rgb.join( " , " ) })"
  end

  # インスタンスの情報を CSV 出力用の文字列（カンマ区切り）にして返すメソッド
  # @return [String]
  def to_csv
    self.to_a.join(",")
  end

  # Red, Green, Blue の各成分の情報を括弧で囲んだ文字列にして返すメソッド
  # @return [String]
  def to_s_rgb_in_parentheses
    "( " + self.to_a_rgb.join( " , ") + " )"
  end

  alias :rgb_in_parentheses :to_s_rgb_in_parentheses

# @!group 色情報の取得

  # Red, Green, Blue の各成分を配列にして返すメソッド
  # @return [::Array <Integer>]
  def to_a_rgb
    [ @red , @green , @blue ]
  end

  # WebColor, Red, Green, Blue の各成分を配列にして返すメソッド
  # @return [::Array <Integer>]
  def to_a
    [ @web ] + self.to_a_rgb
  end

# @!endgroup

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param h [Hash] ハッシュ
  # @return [Color]
  def self.generate_from_hash(h)
    ary = generate_from_hash__set_color_info(h)
    self.new( *ary )
  end

# @!endgroup

  class << self

    private

    # 与えられたハッシュから色情報を取得し、配列にして返すメソッド
    # @param h [Hash] ハッシュ
    # @return [::Array]
    def generate_from_hash__set_color_info(h)
      ary_of_keys = [ :web , :red , :green , :blue ]
      infos = ary_of_keys.map { | key | generate_from_hash__set_variable( h , key ) }
      web , red , green , blue = infos

      if [ red , green , blue ].any? { |i| i.nil? } and web.nil?
        raise "Error"
      end

      # web が定義されていて、red, green, blue（の一部）が未定義の場合
      if web.present? and [ red , green , blue ].any? { |i| i.nil? }
        # red, green, blue を定義する
       red , green , blue = generate_from_hash__set_rgb( web )

     # red, green, blue がすべて定義されていて、web が定義されていない場合
      elsif generate_from_hash__all_rgb_is_defined?( red , green , blue ) and web.nil?
        # web を定義する。
        web = generate_from_hash__set_webcolor( red , green , blue )

      # web, red, green, blue がすべて定義されている場合
      elsif generate_from_hash__all_rgb_is_defined?( red , green , blue ) and web.string?
        generate_from_hash__check_validity_of_variables( web , red , green , blue )
      end

      [ web , red , green , blue ]
    end

    # RGB の各成分が正当に定義されているか否かを判定するメソッド
    # @return [Boolean]
    def generate_from_hash__all_rgb_is_defined?( red , green , blue )
      [ red , green , blue ].all? { |i| i.integer? and i >= 0 and i <= 255 }
    end

    # WebColor をもとに RGB の成分の情報（配列）を取得するメソッド
    # @param web [String] WebColor
    # @return [::Array <Integer>]
    # @note String#to_rgb_color を利用する。
    def generate_from_hash__set_rgb( web )
      web.to_rgb_color
    end

    # RGB の成分の情報をもとに WebColor の情報を取得するメソッド
    # @param red [Integer] R 成分
    # @param green [Integer] G 成分
    # @param blue [Integer] B 成分
    # @return [String]
    def generate_from_hash__set_webcolor( red , green , blue )
      "\#" + [ red , green , blue ].map{ | element | element.to_two_digit_hex }.join
    end

    # WebColor, RGB の各成分が矛盾なく設定されているか否かを確認するメソッド
    # @return [nil]
    def generate_from_hash__check_validity_of_variables( web , red , green , blue )
      unless generate_from_hash__set_rgb( web ) == [ red , green , blue ]
        raise "Error: \[webcolor\] #{web} (#{generate_from_hash__set_rgb( web )}) / \[rgb\] #{red} , #{green} , #{blue} (#{generate_from_hash__set_webcolor( red , green , blue )})"
      end
      return nil
    end

  end

end