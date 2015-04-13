# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::StationTimetable::Info::TrainTime::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::NotOnTheTopLayer

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  def variables
    departure_time = ::DateTime.convert_str( @hash[ "odpt:departureTime" ] )
    terminal_station = @hash[ "odpt:destinationStation" ]
    train_type = @hash[ "odpt:trainType" ]
    is_last = @hash[ "odpt:isLast" ]
    is_origin = @hash[ "odpt:isOrigin" ]
    car_composition = @hash[ "odpt:carComposition" ]
    unless is_last
      is_last = false
    end
    unless is_origin
      is_origin = false
    end

    # 列車の補足情報のインスタンスを取得
    note = self.class.train_info_note_list_class.generate_from_string( @hash[ "odpt:note" ] )

    [ departure_time , terminal_station , train_type , is_last , is_origin , car_composition , note ]
  end

  def self.instance_class
    train_info_class
  end

end