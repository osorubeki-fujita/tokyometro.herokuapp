# 各種ハッシュを作成するための Factory クラス (1)
class TokyoMetro::Factories::StaticDatas::MetaClass::Fundamental

  # Constructor
  # @param filename [String] YAML ファイルの名称
  def initialize( filename )
    @file = filename
  end

  # YAML ファイルからインスタンスを生成するためのインスタンスメソッド
  # @return [subclass of Hash]
  def generate( method_for_hash_class: :hash_class )
    inspect_title
    h_yaml = ::YAML.load_file( @file )
    h_new = self.class.send( method_for_hash_class ).new
    h_new = generate_procedure( h_yaml , h_new )
    h_new
  end

  private

  # YAML ファイルからインスタンスを生成する際のロジック
  # @return [Proc]
  def generate_procedure( h_yaml , h_new )
    h_yaml.each do | key , value |
      h_new[ key ] = self.class.info_class.generate_from_hash( key , value )
    end
    h_new
  end

  def inspect_title
    puts "#{inspect_title_top} #{self.class.name}"
    puts "  from #{ @file }"
    puts "  self.class.info_class #{ self.class.info_class.name }"
    puts ""
  end

  def inspect_title_top
    "●"
  end

  # YAML ファイルからインスタンスを生成するクラスメソッド
  # @param filename [String or nil] ファイル名（nil を指定した場合は、yaml_file <private class method> を呼び出す）
  def self.from_yaml( filename = nil , method_for_hash_class: :hash_class )
    if filename.nil?
      filename = yaml_file
    end
    self.new( filename ).generate( method_for_hash_class: method_for_hash_class )
  end

  # ハッシュのクラス
  # @return [Const (class name)]
  def self.hash_class
    raise "The class method \"#{__method__}\" is not defined yet in this class."
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