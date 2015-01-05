# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::StationTimetable < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  include TokyoMetro::ClassNameLibrary::Api::StationTimetable

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]
    date = @hash[ "dc:date" ]
    station = @hash[ "odpt:station" ]
    railway_line = @hash[ "odpt:railway" ]
    operator = @hash[ "odpt:operator" ]
    railway_direction = @hash[ "odpt:railDirection" ]

    weekdays = generate_timetable_data_from_hash( "odpt:weekdays" )
    saturdays = generate_timetable_data_from_hash( "odpt:saturdays" )
    holidays = generate_timetable_data_from_hash( "odpt:holidays" )

    [ id , same_as , date , station , railway_line , operator , railway_direction , 
      weekdays , saturdays , holidays ]
  end

  private

  def generate_timetable_data_from_hash( key )
    self.class.train_list_class.new( @hash[ key ].map { | train |
      self.class.train_class.generate_from_hash( train )
    } )
  end

end