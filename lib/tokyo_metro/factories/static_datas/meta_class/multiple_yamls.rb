# 各種ハッシュを作成するための Factory クラス (3)
# @note TokyoMetro::StaticDatas::TrainType::Custom::Main , TokyoMetro::StaticDatas::Operator で使用する。
class TokyoMetro::Factories::StaticDatas::MetaClass::MultipleYamls < TokyoMetro::Factories::StaticDatas::MetaClass::Fundamental

  # Constructor
  def initialize( files )
    @files = files
  end

  # YAML ファイルからインスタンスを生成するためのインスタンスメソッド
  # @return [subclass of Hash]
  def generate
    inspect_title
    h_new = self.class.hash_class.new
    h_new = generate_procedure( h_new )
    h_new
  end

  def inspect_title
    puts "● #{self.class.name}"
    puts ""
  end

  undef :inspect_title_top

  private

  # YAML ファイルからインスタンスを生成する際のロジック
  # @return [Proc]
  def generate_procedure( h_new )
    @files.each do | file |
      hash_sub = self.class.factory_for_each_file.from_yaml( file )
      h_new = h_new.merge( hash_sub )
    end
    h_new
  end

  # @note ロジックは {TokyoMetro::Factories::StaticDatas::MetaClass::Fundamental.from_yamls} とほとんど同じだが、デフォルトのファイルがリスト（配列）であることに注意
  def self.from_yamls( files = nil )
    if files.nil?
      files = yaml_files
    end
    self.new( files ).generate
  end

  class << self
    undef :from_yaml
    undef :yaml_file
  end

end