# 各種ハッシュを作成するための Factory クラス - 2.1 複数の YAML ファイルからハッシュを作成
# @note
#   {TokyoMetro::Static::TrainType::Custom::Main} ,{ TokyoMetro::Static::Operator} で使用する。
class TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls < TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromHash

  # Constructor
  def initialize( files )
    @files = files
  end

  # YAML ファイルからインスタンスを生成するためのインスタンスメソッド
  # @return [subclass of Hash]
  def generate
    if TO_INSPECT
      inspect_title
    end

    h_new = self.class.hash_class_for_this_factory.new
    h_new = generating_procedure( h_new )
    h_new
  end

  def inspect_title
    puts "● #{self.class.name}"
    puts " " * 4 + "< TokyoMetro::Factory::Generate::Static::MetaClass::Group::MultipleYamls"
    puts ""
  end

  undef :inspect_title_top

  private

  # YAML ファイルからインスタンスを生成する際のロジック
  # @return [Proc]
  def generating_procedure( h_new )
    @files.each do | file |
      hash_sub = self.class.factory_for_generating_from_each_saved_file.from_yaml( file )
      h_new = h_new.merge( hash_sub )
    end
    h_new
  end

  # @note ロジックは {TokyoMetro::Factory::Generate::Static::MetaClass::Group::Fundamental::FromHash.from_yamls} とほとんど同じだが、デフォルトのファイルがリスト（配列）であることに注意
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