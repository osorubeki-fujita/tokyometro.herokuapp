# 各駅の情報を格納する配列
class TokyoMetro::Api::Station::List < TokyoMetro::Api::MetaClass::Hybrid::List

  # インスタンスの情報を整形した文字列にして返すメソッド
  # @param indent [Integer (>=0)] インデントの幅
  # @return [String]
  def to_strf( indent = 0 )
    super( indent , 2 )
  end

  include ::TokyoMetro::ApiModules::List::Seed
  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::ApiModules::Selection::RailwayLines

  # @return [::Array]
  def connecting_railway_lines
    list_sub( Proc.new { | station | station.connecting_railway_lines } )
  end

  def basenames
    list_sub( Proc.new { | station | station.basename } )
  end

  def basenames_to_display
    list_sub( Proc.new { | station | station.basename_to_display } )
  end

  alias :__seed__ :seed

  # 配列の各要素のインスタンスの情報をDBに流し込むメソッド
  # @return [nil]
  # @note Seed#process_stations では、この処理の実行後に{TokyoMetro::StaticDatas::Station::RailwayLines.seed}が呼び出される。
  def seed( indent: 0 )
    operators = ::Operator.all
    railway_lines = ::RailwayLine.all
    station_facilities = ::StationFacility.all
    __seed__( indent: indent + 1 , method_name: __method__ ) do
      array_for_seed.each do |v|
        v.seed( operators , railway_lines , station_facilities )
      end
    end
  end

  def seed_optional_infos_of_connecting_railway_lines
    __seed__( method_name: __method__ ) do
      array_for_seed.each do |v|
        v.seed_optional_infos_of_connecting_railway_lines
      end
    end
  end

  # 出入口の情報をDBに流し込むメソッド
  # @return [nil]
  def seed_exit_list
    __seed__( method_name: __method__ ) do
      self.each do | station |
        station.seed_exit_list
      end
    end
    return nil
  end

  # 乗降客数の情報をDBに流し込むメソッド
  # @return [nil]
  def seed_station_passenger_survey
    __seed__( method_name: __method__ ) do
      self.each do | station |
        station_id = ::Station.find_by( same_as: station.same_as ).id
        list_of_passenger_survey = station.passenger_survey
        list_of_passenger_survey.each do | data |
          passenger_survey_id = ::PassengerSurvey.find_by( same_as: data ).id
          ::StationPassengerSurvey.create( station_id: station_id , passenger_survey_id: passenger_survey_id )
        end
      end
    end
    return nil
  end

  private

  def list_sub( procedure )
    ary = self.map( &procedure ).flatten.uniq.sort
    ::Array.new( ary )
  end

  # データベースへの流し込みの際に使用する配列（路線・駅のID順に整列している）
  # @return [::TokyoMetro::Api::Station::List]
  def array_for_seed
    stations_in_each_line = self.group_by { | station |
      railway_line_name = station.railway_line
      railway_line = ::RailwayLine.find_by( same_as: railway_line_name )
      if railway_line.nil?
        raise "Error: data of the railway_line same as \"#{railway_name}\" does not exist."
      end
      railway_line.id
    }

    ary = ::Array.new

    stations_in_each_line.keys.sort.each do | line |
      ary += stations_in_each_line[ line ].sort_by { | station | station.station_code }
    end

    self.class.new( ary )
  end

end