# ファイルの情報を扱うクラス
class TokyoMetro::Factories::Api::SaveGroupedData::MetaClass::FileInfo

  # Constructor
  # @param value_ary [::Array] データの配列（グループ化されたハッシュの値）
  # @param key [String] データの ID キー（グループ化されたハッシュのキー）
  # @param regexp [Regexp] 例：/\Aodpt\.Station\:/
  # @param dirname_setting [Symbol or nil] データを保存するディレクトリの設定（標準、アルファベット別、日付別）
  def initialize( value_ary , key , regexp , dirname_setting = nil )
    @list = value_ary
    @filename = set_filename( key , regexp , dirname_setting )
    puts @filename
  end

  # @return [::Array] データの配列（グループ化されたハッシュの値から取得したもの）
  attr_reader :list
  # @return [String (filename)] 保存先のファイル名
  attr_reader :filename

  private

  # 保存するファイルの名称を取得するメソッド
  # @param regexp [Regexp] ファイル名を取得するために使用する正規表現
  # @param dirname_setting [Boolean] アルファベット別または日付別のディレクトリを作成するか否かの設定
  def set_filename( key , regexp , dirname_setting )
    if regexp.instance_of?( ::Regexp )
      # odpt.xxxx: の部分を除去する
      str = key.to_s.gsub( regexp , "" )
    else
      str = key.to_s
    end

    case dirname_setting
    when nil
      str = str.gsub( /[\/\.]/ , "\/" )
    when :station_timetable
      str = str.gsub( /\.(?=[[:alpha:]]+\Z)/ , "_" ).gsub( /[\/\.]/ , "\/" )
    when :train_timetable
      str = set_filename_of_train_timetable( str )
    when :alphabet
      str = set_filename_from_alphabet( str )
    when :date
      str = set_filename_from_date( str )
    else
      raise "Error: #{dirname_setting} is not valid."
    end
    return str.gsub( /\./ , "\/" )
  end

  def set_filename_from_alphabet( str )
    # 駅名を表す正規表現
    regexp_of_station_name = /\A([A-Za-z]+)\.([A-Z])([a-z]+)/
    unless regexp_of_station_name === str
      raise "Error: \"#{str}\" (Class: #{str.class.name} / from: #{key} (#{key.class.name})) is not valid."
    end
    # $1 ... 鉄道事業者の名称
    # $2 ... 駅名の頭文字
    # $2 + $3 ... 駅名
    str.gsub( regexp_of_station_name ) { "#{$1}\/#{$2}\/#{$2}#{$3}" }
  end

  def set_filename_from_date( str )
    date_info = @list.first[ "dc:date" ]
    datetime = DateTime.parse( date_info )
    date_str_y_md = set_date_str_y_md( datetime )
    date_str_hms = set_date_str_hms( datetime )

    "#{date_str_y_md}/#{str}/#{date_str_hms}"
  end

  def set_filename_of_train_timetable( str )
    # 列車番号を表す正規表現
    # 例：odpt.TrainTimetable:TokyoMetro.Ginza.A0501.SaturdaysHolidays
    regexp_of_train_number = /\A([A-Za-z]+)\.([A-Za-z]+)\.([A-Z])(\d+(?:[A-Z]\d?)?)\./
    # $1 ... 鉄道事業者の名称
    # $2 ... 路線名
    # $3 ... 列車番号
    if regexp_of_train_number =~ str
      operator = $1
      railway_line = $2
      direction = $3
      train_number = $3 + $4
    else
      raise "Error: #{str} is not valid."
    end
    if /\A([A-Za-z]+)\Z/ =~ str.gsub( regexp_of_train_number , "" )
      operation_day = $1
    else
      puts str
      operation_day = "All"
    end
    [ operator , railway_line , direction , operation_day , train_number ].join( "\/" )
  end

  def set_date_str_y_md( datetime )
    format_str = "%Y\/%m%d"
    if datetime.hour < ::TokyoMetro::CHANGE_DATE
      datetime.prev_day.strftime( format_str )
    else
      datetime.strftime( format_str )
    end
  end

  def set_date_str_hms( datetime )
    date_str_h = datetime.strftime( "%H" )
    if datetime.hour < ::TokyoMetro::CHANGE_DATE
      date_str_h = ( date_str_h.to_i + 24 ).to_s
    end
    date_str_ms = datetime.strftime( "%M%S" )

    date_str_h + date_str_ms
  end

end