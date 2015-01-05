# 個別の列車種別の情報（実際に時刻表などのクラスから参照されるもの）を扱うクラス
class TokyoMetro::StaticDatas::TrainType::Custom::Main::Info < TokyoMetro::StaticDatas::TrainType::Custom::DefaultSetting::Info

  include TokyoMetro::ClassNameLibrary::StaticDatas::TrainType::Custom::Main

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
  include ::TokyoMetro::StaticDataModules::GetColorInfo::Base
# @!group 文字色に関するメソッド (2)
  include ::TokyoMetro::StaticDataModules::GetColorInfo::EachRgbElement
# @!group 背景色に関するメソッド (1)
  include ::TokyoMetro::StaticDataModules::GetBackgroundColorInfo::Base
# @!group 背景色に関するメソッド (2)
  include ::TokyoMetro::StaticDataModules::GetBackgroundColorInfo::EachRgbElement
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

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] インスタンスの ID として設定する値
  # @param h [Hash] ハッシュ
  # @return [Info]
  def self.generate_from_hash( same_as , h )
    # generate_from_hash__inspect_title( same_as )
    ary_of_keys = generate_from_hash__decided_array_of_keys(h)

    case ary_of_keys
    when [ "ref" ]      
      info = generate_from_hash__info_from_hash(h)
      self.new( same_as , info.train_type , info.bgcolor , info.color , h[ "operator" ] , h[ "railway_line" ]  , h[ "note" ] , h[ "css_class_name_in_document" ] )
    else
      # generate_from_hash__variable_array は、TokyoMetro::StaticDatas::TrainType::Custom::OtherOperator::Info で定義
      ary = generate_from_hash__variable_array(h)
      self.new( same_as , *ary , h[ "note" ] , h[ "css_class_name_in_document" ] )
    end
  end

  def seed
    train_type_in_api_instance = ::TrainTypeInApi.find_by( same_as: @train_type.same_as )
    railway_line_instance = ::RailwayLine.find_by( same_as: @railway_line )
    if train_type_in_api_instance.nil?
      raise "Error: The train type \"#{@train_type}\" is not defined in the database."
    end
    if railway_line_instance.nil?
      raise "Error: The railway line \"#{@railway_line}\" is not defined in the database."
    end

    ::TrainType.create(
      same_as: @same_as ,
      train_type_in_api_id: train_type_in_api_instance.id ,
      color: @color.web_color ,
      bgcolor: @bgcolor.web_color ,
      note: @note ,
      railway_line_id: railway_line_instance.id ,
      css_class_name: css_class_name ,
      css_class_name_in_document: @css_class_name_in_document
    )
  end

# @!endgroup

  class << self

    private

    def generate_from_hash__title
      "TrainTypeDefault"
    end

    def generate_from_hash__decided_array_of_keys(h)
      h.keys - [ "stopping_pattern" , "note" , "note_sub" , "operator" , "railway_line" , "css_class_name_in_document" ]
    end

    # @note {TokyoMetro::StaticDatas::TrainType::Custom::DefaultSetting::Info#generate_from_hash__referenced_hash} を上書き
    def generate_from_hash__referenced_hash
      ::TokyoMetro::StaticDatas.train_types_other_operator.merge( ::TokyoMetro::StaticDatas.train_types_default )
    end

    def generate_from_hash__check_validity_of_info( info , key_for_reference )
      super( info , key_for_reference , kind_of: true )
    end

  end

end