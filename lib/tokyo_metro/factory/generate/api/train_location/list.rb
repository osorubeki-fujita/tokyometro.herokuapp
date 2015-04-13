# 保存済みの列車ロケーション情報 odpt:Train を処理する Factory Pattern のクラス
class TokyoMetro::Factory::Generate::Api::TrainLocation::List < TokyoMetro::Factory::Generate::Api::MetaClass::List::Date

  include ::TokyoMetro::ClassNameLibrary::Api::TrainLocation

  # Constructor
  # @param y [Integer] 情報が保存された年
  # @param m [Integer] 情報が保存された月
  # @param d [Integer] 情報が保存された日
  # @param railway_line [String] 列車ロケーション情報の路線名
  # @param file_type [String (filename)] ファイルの名称
  # @param db_dirname [String (dirname)] データが格納されているディレクトリの名称
  # @param db_dirname_sub [String (dirname) or nil] データが格納されているサブディレクトリの名称
  # @note ni の場合は全路線を取得する。また、具体的な路線名を指定する場合は "Ginza" , "Marunouchi" などと指定する。（一度に指定できるのは1路線のみ）
  def initialize( y , m , d , railway_line , file_type , db_dirname , db_dirname_sub )
    @railway_line = railway_line
    super( y , m , d , file_type , db_dirname , db_dirname_sub )
  end

  # 個々の列車ロケーション情報の配列
  # @param max [Integer or nil] 配列の要素の最大値
  # @note max を nil とした場合は無制限で、同一の路線・年月日のすべての情報を配列に格納する。
  # @return [TokyoMetro::Api::TrainLocation::List]
  def generate( max = nil )
    super( max )
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
  # @return [TokyoMetro::Api::TrainLocation::List]
  def self.process( railway_line , y , m , d , file_type , db_dirname , db_dirname_sub , max )
    self.new( railway_line , y , m , d , file_type , db_dirname , db_dirname_sub ).generate( max )
  end

  private

  def db_dirname
    if @db_dirname_sub.nil?
      "#{@db_dirname}/#{dirname_for_date}/**"
    elsif @db_dirname_sub.string?
      "#{@db_dirname}/#{dirname_for_date}/#{railway_line_dirname}/**"
    else
      raise "Error: The instance variable \"db_dirname_sub\" is not valid."
    end
  end

  def railway_line_dirname
    if @railway_line.nil?
      "TokyoMetro/**"
    elsif @railway_line.string?
      "TokyoMetro/#{@railway_line}"
    else
        raise "Error: The instance variable \"db_dirname_sub\" is not valid."
    end
  end

end