# 個別の種別の色を扱うクラス
class TokyoMetro::Static::TrainType::Color::Info < TokyoMetro::Static::Color

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Color
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info

# @!group Constructor

  # Constructor
  # @param same_as [String] 作成するインスタンスの ID キー
  # @param note [String] 作成するインスタンスの補足情報
  # @param wrgb [::Array] 作成するインスタンスの WebColor と RGB の各成分の情報
  def initialize( same_as , note , *wrgb )
    @same_as = same_as
    @note = note
    super( *wrgb )
  end

# @!group 種別色の ID ・補足情報に関するメソッド

  # @return [String] 種別色の ID（インスタンス変数）
  # @example
  #   TokyoMetro::Static.train_types_color.each_value { | color | puts color.same_as }
  #   =>
  #   custom.TrainTypeColor:White
  #   custom.TrainTypeColor:DarkGray
  #   custom.TrainTypeColor:HolidayExpress
  attr_reader :same_as

  # @return [String] 種別色の補足情報（インスタンス変数）
  # @example
  #   TokyoMetro::Static.train_types_color.each_value { | color | puts color.note }
  #   =>
  #   一般 標準色 白
  #   一般 標準色 グレー
  #   土休急行 標準色（ピンク）
  attr_reader :note

# @!group 種別色の値を取得するメソッド - 例を追加するためだけに定義

  # WebColor を取得するメソッド
  # @return [String]
  # @example
  #   TokyoMetro::Static.train_types_color.each_value { | color | puts color.same_as.ljust(48) + " " + color.web }
  #   =>
  #   custom.TrainTypeColor:White                      #ffffff
  #   custom.TrainTypeColor:DarkGray                   #666666
  #   custom.TrainTypeColor:HolidayExpress             #ff3399
  def web
    super
  end

  # Red, Green, Blue の各成分の情報を括弧で囲んだ文字列にして返すメソッド
  # @return [String]
  # @example
  #   TokyoMetro::Static.train_types_color.each_value { | color | puts color.same_as.ljust(48) + " " + color.rgb_in_parentheses }
  #   =>
  #   custom.TrainTypeColor:White                      ( 255 , 255 , 255 )
  #   custom.TrainTypeColor:DarkGray                   ( 102 , 102 , 102 )
  #   custom.TrainTypeColor:HolidayExpress             ( 255 , 51 , 153 )
  def rgb_in_parentheses
    super
  end

# @!group インスタンスの基本的な情報を取得するメソッド

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( other )
    @same_as <=> other.same_as
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_s( indent = 0 )
    if @same_as.nil?
      same_as = "----"
    else
      same_as = @same_as.to_s
    end
    [ same_as , @note.to_s ].map { | str |" " * indent + str }.join( "\n" ) + "\n" + " " * ( indent + 2 ) + super(0)
  end

# @!endgroup

end