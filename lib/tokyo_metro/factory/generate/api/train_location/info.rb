# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::TrainLocation::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::TrainLocation

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    same_as = @hash[ "owl:sameAs" ]

    dc_date = DateTime.parse( @hash[ "dc:date" ] )
    valid = DateTime.parse( @hash[ "dct:valid" ] )
    frequency = @hash[ "odpt:frequency" ]

    train_number = @hash[ "odpt:trainNumber" ]
    train_type = @hash[ "odpt:trainType" ]

    railway_direction = @hash[ "odpt:railDirection" ]
    railway_line = @hash[ "odpt:railway" ]
    train_owner = @hash[ "odpt:trainOwner" ]

    starting_station = @hash[ "odpt:startingStation" ]
    terminal_station = @hash[ "odpt:terminalStation" ]

    delay = @hash[ "odpt:delay" ]

    from_station = @hash[ "odpt:fromStation" ]
    to_station = @hash[ "odpt:toStation" ]

    [ id , same_as , train_number , train_type , dc_date , valid , frequency ,
      railway_line , train_owner , railway_direction , delay , starting_station , terminal_station , from_station , to_station ]
  end

end