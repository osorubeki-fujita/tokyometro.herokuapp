class TokyoMetro::ApiModules::TimetableModules::TrainTimetable::Info::Seed::PatternB::TrainTypeFactoryOfEachTrain < TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactory

  @patterns = ::Array.new

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::StartingStation
  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::ConvertRailwayLine

  Pattern = Struct.new( :pattern_id , :train_type_same_as , :railway_line_id , :terminal_station_id , :operation_day_id , :starting_station_id )

  class Pattern

    include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::PatternModules::Methods

    def match?( train_type_same_as ,  railway_line_id , terminal_station_id , operation_day_id , starting_station_id )
      match_fundamental( train_type_same_as ,  railway_line_id , terminal_station_id , operation_day_id ) and starting_station_is?( starting_station_id )
    end

    private

    def starting_station_is?( starting_station_id )
      self[ :starting_station_id ] == starting_station_id
    end

  end

  def initialize( train_type_same_as , railway_line_instance , starting_station_instance , terminal_station_instance , operation_day_instance )
    super( train_type_same_as , railway_line_instance , terminal_station_instance , operation_day_instance )
    @starting_station_instance = starting_station_instance
  end

  def to_a
    super + [ @starting_station_instance.id ]
  end

  def self.train_type_pattern_class
    ::TokyoMetro::ApiModules::TimetableModules::TrainTimetable::Info::Seed::PatternB::TrainTypeFactoryOfEachTrain::Pattern
  end

  private

  def toei_mita_line_train_in_namboku_line?
    namboku_line? and ( is_starting_on_toei_mita_line? or is_terminating_on_toei_mita_line? )
  end

  # 有楽町線・副都心線の列車種別を取得するメソッド
  # @return [TrainType(s)]
  # @note 上位クラスのメソッドを上書きしている。
  def yurakucho_and_fukutoshin_train_type
    #-------- 「休日急行」（明治神宮前に停車）対策
    process_holiday_express_of_fukutoshin_line

    #-------- 列車種別（API）の取得
    train_type_in_api_instance = ::TrainTypeInApi.find_by_same_as( @train_type_same_as )

    #-------- 路線名の変換
    process_railway_line_name_of_yurakucho_and_fukutoshin_line

    h = {
      railway_line_id: @railway_line_instance.id ,
      train_type_in_api: train_type_in_api_instance.id
    }
    train_types = ::TrainType.where(h).select_colored_if_exist
    select_one_from_multiple_train_types( train_types )
  end

  # 路線名の変換
  # @return [nil]
  # @note このクラス特有のメソッド
  def process_railway_line_name_of_yurakucho_and_fukutoshin_line
    #-------- 終着駅が和光市・西武線・東武線方面
    if ( is_terminating_on_tobu_tojo_line? or is_terminating_at_wakoshi? ) or is_terminating_on_seibu_line?
      #-------- 始発駅が有楽町線
      if is_starting_on_yurakucho_line?
        convert_railway_instance_to_yurakucho_line
      #-------- 始発駅が副都心線・東急東横線・みなとみらい線
      elsif is_starting_on_fukutoshin_line? or is_starting_on_tokyu_toyoko_line? or is_starting_on_minatomirai_line?
        convert_railway_instance_to_fukutoshin_line
      end
    #-------- 終着駅が有楽町線
    elsif is_terminating_on_yurakucho_line?
      convert_railway_instance_to_yurakucho_line
    #-------- 終着駅が副都心線・東急東横線・みなとみらい線
    elsif is_terminating_on_fukutoshin_line? or is_terminating_on_tokyu_toyoko_line? or is_terminating_on_minatomirai_line?
      convert_railway_instance_to_fukutoshin_line
    else
      raise error_msg
    end

    return nil
  end

  def error_msg__additional_ary
    str_ary = ::Array.new
    [
      [ "Railway line" , @railway_line_instance.same_as ] ,
      [ "Starting station" , @starting_station_instance.same_as ] ,
      [ "Terminal station" , @terminal_station_instance.same_as ] ,
      [ "Operation day" , @operation_day_instance.name_en ]
    ].each do | title , info |
      str_ary << title.ljust(24) + " ... " + info
    end
    str_ary
  end

end