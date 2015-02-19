# 個別の列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラス
class TokyoMetro::Static::TrainType::Custom::Main::Info < TokyoMetro::Static::TrainType::Custom::DefaultSetting::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  # Constructor
  # @param ary [::Array] 変数の配列（内部で展開する）
  def initialize( *ary )
    *defined_in_superclass , note , css_class_name_in_document = ary
    super( *defined_in_superclass )
    @note = note
    @css_class_name_in_document = css_class_name_in_document
    raise "Error: #{@same_as}" if @railway_line.nil?
  end

  # @return [String] 補足情報
  attr_reader :note

  # @return [String or nil] ドキュメント内で使用する CSS のクラス名
  attr_reader :css_class_name_in_document

# @!group 文字色に関するメソッド (1)
  include ::TokyoMetro::Modules::Static::GetColorInfo::Base
# @!group 文字色に関するメソッド (2)
  include ::TokyoMetro::Modules::Static::GetColorInfo::EachRgbElement
# @!group 背景色に関するメソッド (1)
  include ::TokyoMetro::Modules::Static::GetBackgroundColorInfo::Base
# @!group 背景色に関するメソッド (2)
  include ::TokyoMetro::Modules::Static::GetBackgroundColorInfo::EachRgbElement
# @!endgroup

  alias :name_ja_to_haml :note
  alias :name_en_to_haml :name_en_normal

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    str_1 = super( indent )
    key_css = "css_class_name"
    str_1 + "\n" + " " * indent + key_css.ljust(32) + self.__send__( key_css )
  end

# @!group CSS に関するメソッド

  # CSS のクラスの名称
  # @return [String]
  def css_class_name
    "train_type_" + @same_as.gsub( /\Acustom\.TrainType\:/ , "" ).gsub( "TokyoMetro." , "" ).gsub( "\." , "_" ).underscore.downcase
  end

# @!endgroup

end