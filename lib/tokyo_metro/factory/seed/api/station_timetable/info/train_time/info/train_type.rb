class TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info::TrainType < TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainType

  @patterns = ::Array.new

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase

  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::CurrentStation
  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::ConvertRailwayLine

  def initialize( train_type , railway_line_in_db , terminal_station_in_db , operation_day_in_db , stations_in_db )
    super( train_type , railway_line_in_db , terminal_station_in_db , operation_day_in_db )
    @stations_in_db = stations_in_db
  end

  def to_a
    super + [ @stations_in_db.pluck( :id ) ]
  end

  def self.train_type_pattern_class
    ::TokyoMetro::Factory::Seed::Api::StationTimetable::Info::TrainTime::Info::TrainType::Pattern
  end

  private

  # 南北線内の都営三田線の列車か否かを判定するメソッド
  # @return [Boolean]
  # @note 上位クラスのメソッドを上書きしている。
  def toei_mita_line_train_for_nishi_takashimadaira?
    namboku_or_toei_mita_line_train_for_nishi_takashimadaira? and at_namboku_and_toei_mita_line_common_station?
  end

  alias :is_toei_mita_line_train_for_nishi_takashimadaira? :toei_mita_line_train_for_nishi_takashimadaira?

  def considered_train_types_of_yurakucho_and_fukutoshin_line

    #-------- 有楽町線・副都心線の単独区間の駅の場合
    if !( at_yurakucho_and_fukutoshin_common_station? )
      train_types.select( &:normal? )

    #-------- 有楽町線・副都心線の共用区間の駅の場合

    #-------- 小竹向原から和光市方面に行く場合 or 西武線方面へ行く場合
    elsif ( terminating_on_tobu_tojo_line? or terminating_at_wakoshi? ) or terminating_on_seibu_line?
      # 「有楽町線急行」「有楽町線通勤急行」対策
      process_railway_line_of_between_wakoshi_and_kotake_mukaihara
      train_types.select( &:normal? )

    else
     select_train_types_to_yurakucho_fukutoshin_or_tokyu_mm_line
    end
  end

  def error_msg__additional_ary_base
    [
      [ "Train type" , @train_type ] ,
      [ "Railway line" , @railway_line_in_db.same_as ] ,
      [ "Station" , @stations_in_db.map( &:same_as ) ] ,
      [ "Terminal station" , @terminal_station_in_db.same_as ] ,
      [ "Operation day" , @operation_day_in_db.name_en ]
    ]
  end

  # 千代田線の列車種別を選択するためのメソッド（乗り入れがない場合）
  # @return [Regexp]
  # @note 上位クラスのメソッドを上書きしている。
  def regexp_to_select_train_type_chiyoda_except_for_for_odakyu_or_jr_joban_line
    if ( is_terminating_at_ayase? and at_kita_ayase? ) or ( is_terminating_at_kita_ayase? and at_ayase? )
      /KitaAyase\Z/
    else
      /Normal\Z/
    end
  end

  # @!group 路線を処理するメソッド

  # 「有楽町線急行」「有楽町線通勤急行」対策
  # @return [nil]
  # @note このクラス特有のメソッド
  def process_railway_line_of_between_wakoshi_and_kotake_mukaihara
    if yurakucho_line? and between_wakoshi_and_kotake_mukaihara? and ( express? or holiday_express? or commuter_express? )
      convert_railway_instance_to_fukutoshin_line
    end
    return nil
  end

  # @!endgroup

end