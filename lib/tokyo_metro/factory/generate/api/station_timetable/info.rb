# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationTimetable::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  include TokyoMetro::ClassNameLibrary::Api::StationTimetable

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]
    dc_date = @hash[ "dc:date" ]

    # station = @hash[ "odpt:station" ]
    # railway_line = @hash[ "odpt:railway" ]
    # operator = @hash[ "odpt:operator" ]
    # railway_direction = @hash[ "odpt:railDirection" ]

    fundamental_infos = station_fundamental_infos

    weekdays = generate_timetable_data_from_hash( "odpt:weekdays" )
    saturdays = generate_timetable_data_from_hash( "odpt:saturdays" )
    holidays = generate_timetable_data_from_hash( "odpt:holidays" )

    # [ id , same_as , dc_date , station , railway_line , operator , railway_direction , 
      # weekdays , saturdays , holidays ]

    [ id , same_as , dc_date , fundamental_infos , 
      weekdays , saturdays , holidays ]
  end

  private

  def station_fundamental_infos
    self.class.fundamental_list_class.new( [
      self.class.fundamental_info_class.generate_from_hash( @hash )
    ] )
  end

  def generate_timetable_data_from_hash( key )
    self.class.train_list_class.new( @hash[ key ].map { | train |
      self.class.train_info_class.generate_from_hash( train )
    } )
  end

end