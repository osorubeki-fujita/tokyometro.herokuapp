# 日付ごとに保存された情報を処理する Factory Pattern のクラス
class TokyoMetro::Factory::Generate::Api::MetaClass::List::Date < TokyoMetro::Factory::Generate::Api::MetaClass::List::Normal

  # Constructor
  # @param y [Integer] 情報が保存された年
  # @param m [Integer] 情報が保存された月
  # @param d [Integer] 情報が保存された日
  # @param file_type [String (filename)] ファイルの名称
  # @param db_dirname [String (dirname)] データが格納されているディレクトリの名称
  # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
  def initialize( y , m , d , file_type , db_dirname , db_dirname_sub )
    @year = y
    @month = d
    @date = d

    @file_type = file_type
    @db_dirname = db_dirname
    @db_dirname_sub = db_dirname_sub
  end

  # 取得するファイルを表すワイルドカード
  # @return [String]
  def filename_wildcard
    "#{db_dirname}/**.#{@file_type.to_s}"
  end

  # 保存済みの情報からインスタンスの配列を復元するメソッド
  # @param y [Integer] 情報が保存された年
  # @param m [Integer] 情報が保存された月
  # @param d [Integer] 情報が保存された日
  # @param file_type [String (filename)] ファイルの名称
  # @param db_dirname [String (dirname)] データが格納されているディレクトリの名称
  # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
  # @param max [Integer or nil] 配列の要素の最大値
  # @note max を nil とした場合は無制限で、すべての情報を配列に格納する。
  # @return [subclass of TokyoMetro::Api::MetaClass::Fundamental::List]
  def self.process( y , m , d , file_type , db_dirname , db_dirname_sub , max )
    self.new( y , m , d , file_type , db_dirname , db_dirname_sub ).generate( max )
  end

  private

  def db_dirname
    if @db_dirname_sub.nil?
      "#{@db_dirname}/#{dirname_for_date}/**"
    elsif @db_dirname_sub.string?
      "#{@db_dirname}/#{dirname_for_date}/#{@db_dirname_sub}"
    else
      raise "Error: The instance variable \"db_dirname_sub\" is not valid."
    end
  end

  def dirname_for_date
    y_str = sprintf("%4.4d", @year )
    m_str = sprintf("%2.2d", @month )
    d_str = sprintf("%2.2d", @date )
    "#{y_str}/#{m_str}#{d_str}"
   end

end