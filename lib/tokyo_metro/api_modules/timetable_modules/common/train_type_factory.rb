class TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactory

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::ProcessPatterns

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::RailwayLine
  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::TrainType
  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::TerminalStation
  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::OperationDay

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::RegexpLibrary

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::YurakuchoAndFukutoshinLine
  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::NambokuAndToeiMitaLine

  include ::TokyoMetro::CommonModules::Decision::RomanceCar

  # インスタンス変数 station_instance が定義されているサブクラスで include する
  # include CurrentStation

  # インスタンス変数 starting_station_instance が定義されているサブクラスで include する
  # include StartingStation

  # Constructor
  def initialize( train_type_same_as , railway_line_instance , terminal_station_instance , operation_day_instance )
    @train_type_same_as = train_type_same_as
    @railway_line_instance = railway_line_instance
    @terminal_station_instance = terminal_station_instance
    @operation_day_instance = operation_day_instance
  end

  attr_reader :train_type_same_as
  attr_reader :railway_line_instance
  attr_reader :terminal_station_instance
  attr_reader :operation_day_instance

  def to_a
    [ @train_type_same_as , @railway_line_instance.id , @terminal_station_instance.id , @operation_day_instance.id ]
  end

  def self.id_in_db( *variables )
    self.new( *variables ).get_id_in_db
  end

  def get_id_in_db
    pt = pattern
    if pt.present?
      return pt[ :pattern_id ]
    end

    # 特急ロマンスカー
    if romance_car_on_chiyoda_line?
      train_type = ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Chiyoda.RomanceCar.Normal" )

    # 半蔵門線 東急方面 休日（南町田に停車）
    elsif hanzomon_line? and operated_on_holiday? and is_terminating_on_tokyu_den_en_toshi_line?
      train_type = ::TrainType.find_by_same_as( "custom.TrainType:TokyoMetro.Hanzomon.HolidayExpress.ToTokyu" )

    # 南北線・三田線共用区間の三田線方面行き列車
    elsif toei_mita_line_train_in_namboku_line?
      train_type = ::TrainType.find_by_same_as( "custom.TrainType:Toei.Mita.Local.Normal" )

    # 有楽町線・副都心線
    elsif yurakucho_or_fukutoshin_line?
      train_type = yurakucho_and_fukutoshin_train_type

    else
      train_type = get_train_type
    end

    train_type_id = train_type.id
    add_pattern( train_type_id )

    return train_type_id
  end

  private

  # @!endgroup

  def select_one_from_multiple_train_types( train_types , regexp = nil )
    case train_types.length
    when 1
      train_types.first
    else
      puts train_types.map { | item | item.same_as }
      raise error_msg( regexp )
    end
  end

  def get_train_type
    train_type_in_api = ::TrainTypeInApi.find_by_same_as( @train_type_same_as )
    if train_type_in_api.nil?
      raise "Error: \"#{ @train_type_same_as }\" (#{ @train_type_same_as.class.name }) does not exist in the database."
    end
    train_type_h = {
      railway_line_id: @railway_line_instance.id ,
      train_type_in_api_id: train_type_in_api.id
    }
    train_types = ::TrainType.where( train_type_h )

    case train_types.length
    when 0
      raise "Error: The train type \"#{ @train_type_same_as }\" in \"#{ ::RailwayLine.find_by_id( @railway_line_instance.id ).same_as }\" is not defined."
    when 1
      train_types.first
    else
      regexp = regexp_to_select_train_type
      selected_train_types = train_types.select { | train_type | regexp =~ train_type.same_as }

      select_one_from_multiple_train_types( selected_train_types , regexp )
    end
  end

  # エラーメッセージを作成するメソッド
  # @note エラーそのものを立ち上げるわけではない。
  #   raise error_msg( regexp ) でエラーが発生する。
  # @note 必要に応じてサブクラスで上書きする。
  # @return [String]
  def error_msg( regexp = nil )
    str_ary = error_msg__base_ary
    str_ary += error_msg__additional_ary
    if regexp.present?
      str_ary << error_msg__regexp_str( regexp )
    end
    str_ary.join( "\n" )
  end

  def error_msg__base_ary
    str_ary = ::Array.new
    str_ary << ""
    str_ary << "\[#{ self.class.name }\]"
    str_ary << "Error: The train type \"#{ @train_type_same_as }\" which matches following informations is not defined."
    str_ary
  end

  def error_msg__additional_ary
    str_ary = ::Array.new
    [
      [ "Railway line" , @railway_line_instance.same_as ] ,
      [ "Terminal station" , @terminal_station_instance.same_as ] ,
      [ "Operation day" , @operation_day_instance.name_en ]
    ].each do | title , info |
      str_ary << title.ljust(24) + " ... " + info
    end
    str_ary
  end

  def error_msg__regexp_str( regexp )
    "Regexp".ljust(24) + " ... " + regexp.to_s
  end

end