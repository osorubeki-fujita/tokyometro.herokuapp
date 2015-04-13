class TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo::TrainTimetable < TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo

  private

  def set_filename_according_to_settings( str )
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

end