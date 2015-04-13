# 保存済みの情報を処理する Factory Pattern のクラス
class TokyoMetro::Factory::Generate::Api::MetaClass::List::Normal

  # Constructor
  # @param file_type [String (filename)] ファイルの名称
  # @param db_dirname [String (dirname)] データが格納されているディレクトリの名称
  # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
  def initialize( file_type , db_dirname , db_dirname_sub )
    @file_type = file_type
    @db_dirname = db_dirname
    @db_dirname_sub = db_dirname_sub
  end

  # ファイルのリスト
  # @param max [Integer or nil] 配列の要素の最大値
  # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
  # @return [::Array]
  def filename_list( max = nil )
    # @todo 遅延評価
    files = ::Dir.glob( self.filename_wildcard )
    if max.integer?
      files = files.first( max )
    end
    inspect_info_of_generating_filename_list( files )
    files
  end

  # 取得するファイルを表すワイルドカード
  # @return [String]
  def filename_wildcard
    "#{ db_dirname }/**.#{ @file_type.to_s }"
  end

  # 保存済みの情報からインスタンスの配列を復元するメソッド（インスタンスメソッド）
  # @param max [Integer or nil] 配列の要素の最大値
  # @note max を nil とした場合は無制限で、すべてのファイルを配列に格納する。
  # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
  def generate( max = nil )
    ary_new = self.class.list_class.new
    files = self.filename_list( max )
    files.each.with_index(1) do | filename , i |
      infos_in_a_file = open_and_process_a_file( filename )
      infos_in_a_file.each do | info |
        ary_new << info
      end
      inspect_info_of_generation(i)
    end
    ary_new
  end

  # 保存済みの情報からインスタンスの配列を復元するメソッド（クラスメソッド）
  # @param file_type [String (filename)] ファイルの名称
  # @param db_dirname [String (dirname)] データが格納されているディレクトリの名称
  # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
  # @param max [Integer or nil] 配列の要素の最大値
  # @note max を nil とした場合は無制限で、すべての情報を配列に格納する。
  # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
  def self.process( file_type , db_dirname , db_dirname_sub , max )
    self.new( file_type , db_dirname , db_dirname_sub ).generate( max )
  end

  # @!group 生成するクラスの情報

  # 配列のクラス
  # @return [Const (class)]
  def self.list_class
    raise "The class method \"#{__method__}\" is not defined yet in this class \"#{ self.name }\"."
  end

  # 配列の要素となるインスタンスのクラス
  # @return [Const (class)]
  def self.info_class
    raise "The class method \"#{__method__}\" is not defined yet in this class \"#{ self.name }\"."
  end

  # @!endgroup

  private

  def db_dirname
    if @db_dirname_sub.nil?
      "#{ @db_dirname }/**"
    elsif @db_dirname_sub.string?
      "#{ @db_dirname }/#{ @db_dirname_sub }"
    else
      raise "Error: The instance variable \"db_dirname_sub\" is not valid."
    end
  end

  def inspect_info_of_generating_filename_list( files )
    unless files.empty?
      puts "Generate instances of \"#{ self.class.info_class.name }\" from #{ files.length } files"
      puts "that are matched with \"#{ filename_wildcard }\"."
    else
      puts "There is no file that are matched with \"#{ filename_wildcard }\"."
      raise "Error"
    end
  end

  def open_and_process_a_file( filename )
    case @file_type
    when :json
      ary_from_file = ::JSON.load( open( filename , "r:utf-8" ).read )
    when :yaml
      ary_from_file = ::YAML.load_file( filename )
    end
    ary_from_file.map { | element | self.class.info_class.generate_from_hash( element ) }
  end

  def inspect_info_of_generation(i)
    if i % 100 == 0
      puts i
    end
  end

end