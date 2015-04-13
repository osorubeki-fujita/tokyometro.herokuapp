class TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::TrainType < TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainType

  @patterns = ::Array.new

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase

  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::StartingStation
  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::ConvertRailwayLine

  def initialize( train_type , railway_line_in_db , starting_station_in_db , terminal_station_in_db , operation_day_in_db )
    super( train_type , railway_line_in_db , terminal_station_in_db , operation_day_in_db )
    @starting_station_in_db = starting_station_in_db
  end

  def to_a
    super + [ @starting_station_in_db.id ]
  end

  def self.train_type_pattern_class
    ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::TrainType::Pattern
  end

  undef :select_train_types_to_yurakucho_fukutoshin_or_tokyu_mm_line

  private

  def considered_train_types_of_yurakucho_and_fukutoshin_line

    #-------- 路線名の変換
    process_railway_line_name_of_yurakucho_and_fukutoshin_line

    train_types.select_colored_if_exist
  end

  # 路線名の変換
  # @return [nil]
  # @note このクラス特有のメソッド
  def process_railway_line_name_of_yurakucho_and_fukutoshin_line
    #-------- 終着駅が和光市・西武線・東武線方面
    if ( terminating_on_tobu_tojo_line? or is_terminating_at_wakoshi? ) or terminating_on_seibu_line?
      #-------- 始発駅が有楽町線
      if starting_on_yurakucho_line?
        convert_railway_instance_to_yurakucho_line
      #-------- 始発駅が副都心線・東急東横線・みなとみらい線
      elsif starting_on_fukutoshin_line? or starting_on_tokyu_toyoko_line? or starting_on_minatomirai_line?
        convert_railway_instance_to_fukutoshin_line
      end
    #-------- 終着駅が有楽町線
    elsif terminating_on_yurakucho_line?
      convert_railway_instance_to_yurakucho_line
    #-------- 終着駅が副都心線・東急東横線・みなとみらい線
    elsif terminating_on_fukutoshin_line? or terminating_on_tokyu_toyoko_line? or terminating_on_minatomirai_line?
      convert_railway_instance_to_fukutoshin_line
    else
      raise error_msg
    end

    return nil
  end

  def error_msg__additional_ary_base
    [
      [ "Train type" , @train_type ] ,
      [ "Railway line" , @railway_line_in_db.same_as ] ,
      [ "Starting station" , @starting_station_in_db.same_as ] ,
      [ "Terminal station" , @terminal_station_in_db.same_as ] ,
      [ "Operation day" , @operation_day_in_db.name_en ]
    ]
  end

end