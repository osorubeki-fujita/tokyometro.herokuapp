class TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainType

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase

  include ::TokyoMetro::Modules::Common::Info::Decision::RomanceCar
  include ::TokyoMetro::Modules::Common::Info::Decision::ToeiMitaLine

  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::ProcessPatterns

  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::RailwayLine
  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::TrainType
  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::TerminalStation
  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::OperationDay

  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::RegexpLibrary

  include ::TokyoMetro::Factory::Seed::Api::MetaClass::Timetables::TrainTypeModules::YurakuchoAndFukutoshinLine

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::TrainType
  include ::TokyoMetro::Factory::Seed::Reference::TrainTypeInApi
  include ::TokyoMetro::Factory::Seed::Reference::Dictionary::TrainType

  # インスタンス変数 station_in_db が定義されているサブクラスで include する
  # include CurrentStation

  # インスタンス変数 starting_station_in_db が定義されているサブクラスで include する
  # include StartingStation

  # Constructor
  def initialize( train_type , railway_line_in_db , terminal_station_in_db , operation_day_in_db )
    @train_type = train_type
    @railway_line_in_db = railway_line_in_db
    @terminal_station_in_db = terminal_station_in_db
    @operation_day_in_db = operation_day_in_db
  end

  attr_reader :train_type
  attr_reader :railway_line_in_db
  attr_reader :terminal_station_in_db
  attr_reader :operation_day_in_db

  def to_a
    [ @train_type , @railway_line_in_db.id , @terminal_station_in_db.id , @operation_day_in_db.id ]
  end

  def self.id_in_db( *variables )
    self.new( *variables ).get_id_in_db
  end

  def get_id_in_db
    pt_id = get_id_in_db_when_pattern_exists

    if pt_id.present?
      pt_id
    else
      get_id_in_db_when_pattern_does_not_exist
    end
  end

  # @!endgroup

  private

  def get_id_in_db_when_pattern_exists
    pt = pattern
    if pt.present?
      pt.pattern_id
    else
      nil
    end
  end

  def get_id_in_db_when_pattern_does_not_exist
    train_type_id = train_type_in_db.id
    add_pattern( train_type_id )

    return train_type_id
  end

  def train_type_in_db
    # 特急ロマンスカー
    if romance_car_on_chiyoda_line?
      romance_car
    # 半蔵門線 東急方面 休日（南町田に停車）
    elsif hanzomon_line? and operated_on_holiday? and is_terminating_on_tokyu_den_en_toshi_line?
      hanzomon_line_holiday_express_to_tokyu_den_en_toshi_line_stopping_at_minami_machida

    # 南北線・三田線共用区間の三田線方面（西高島平方面）行き列車
    #   @note TokyoMetro::Modules::Common::Info::Decision::ToeiMitaLine#toei_mita_line_train_for_nishi_takashimadaira? を用いる。
    #   @note #toei_mita_line_train_for_nishi_takashimadaira? は必要に応じて上書きする。
    elsif toei_mita_line_train_for_nishi_takashimadaira?
      toei_mita_line_local_train_normal
    # 有楽町線・副都心線
    elsif yurakucho_or_fukutoshin_line?
      yurakucho_and_fukutoshin_train_type
    else
      get_train_type
    end
  end

  def get_train_type
    _considered_train_types = considered_train_types

    case _considered_train_types.length
    when 1
      _considered_train_types.first
    else
      _regexp = regexp_to_select_train_type
      selected_train_types = _considered_train_types.select { | train_type | _regexp =~ train_type.same_as }
      select_one_from_multiple_train_types( selected_train_types , _regexp )
    end
  end

  def considered_train_types
    t = train_types
    if t.blank?
      raise "Error: The train type \"#{ @train_type }\" in \"#{ @railway_line_in_db.same_as }\" is not defined."
    end
    t
  end

  def select_one_from_multiple_train_types( selected_train_types , regexp = nil )
    case selected_train_types.length
    when 1
      selected_train_types.first
    else
      puts selected_train_types.map( &:same_as )
      raise error_msg( regexp )
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
    str_ary << "Error: The train type \"#{ @train_type }\" which matches following informations is not defined."
    str_ary
  end

  def error_msg__additional_ary
    str_ary = ::Array.new
    error_msg__additional_ary_base.each do | title , info |
      str_ary << title.ljust(24) + " ... " + info.to_s
    end
    str_ary
  end

  def error_msg__additional_ary_base
    [
      [ "Train type" , @train_type ] ,
      [ "Railway line" , @railway_line_in_db.same_as ] ,
      [ "Terminal station" , @terminal_station_in_db.same_as ] ,
      [ "Operation day" , @operation_day_in_db.name_en ]
    ]
  end

  def error_msg__regexp_str( regexp )
    "Regexp".ljust(24) + " ... " + regexp.to_s
  end

  def railway_line_in_db( whole = nil , search_by: nil )
    if whole.nil? and search_by.nil?
      @railway_line_in_db
    else
      super( whole , search_by: search_by )
    end
  end

  def railway_line_id( whole = nil , search_by: nil )
    if whole.nil? and search_by.nil?
      @railway_line_in_db.id
    else
      super( whole , search_by: search_by )
    end
  end

end