# 各種ハッシュを作成するための Factory クラス - 0. 基本
# @note
#   単一の YAML ファイルからハッシュを作成するクラスは、このクラス {TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromHash} を継承して作成する。
#   また、複数の YAML ファイルからハッシュを作成するクラスも、このクラス {TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromHash} を継承するクラス {TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls} , {TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls::EachFile} をさらに継承して作成する。
class TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental

  TO_INSPECT = false

  include TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  # Constructor
  # @param filename [String] YAML ファイルの名称
  def initialize( filename )
    @file = filename
  end

  # YAML ファイルからインスタンスを生成するためのインスタンスメソッド
  # @return [subclass of Hash]
  def generate
    if TO_INSPECT
      inspect_title
    end

    generating_procedure( ::YAML.load_file( @file ) )
  end

  private

  def inspect_title
    puts "#{inspect_title_top} #{self.class.name}"
    puts " " * 4 + "< #{self.class.superclass.name}"
    puts ""
    puts " " * 4 + "from".ljust(24) + " : " + @file
    puts " " * 4 + "self.class.info_class".ljust(24) + " : " + self.class.info_class.name
    puts ""
    puts ""
  end

  def inspect_title_top
    "●"
  end

  # YAML ファイルからインスタンスを生成するクラスメソッド
  # @param filename [String or nil] ファイル名（nil を指定した場合は、yaml_file <private class method> を呼び出す）
  # @note ファイル名は必ず指定しなければならない。
  def self.from_yaml( filename = nil , method_for_hash_class: :hash_class )
    if filename.nil?
      filename = yaml_file
    end
    self.new( filename ).generate
  end

  def self.info_class_for_this_factory
    info_class
  end

  # ハッシュの値のクラス
  # @return [Const (class name)]
  def self.info_class
    raise "The class method \"#{__method__}\" is not defined yet in this class."
  end

  class << self

    private

    def yaml_file
      "#{ ::TokyoMetro::dictionary_dir }/#{yaml_file_basename}.yaml"
    end

  end

end