# 個別の路線の、個別の駅の情報を扱うクラス
class TokyoMetro::StaticDatas::Station::InEachRailwayLine::Info

  include ::TokyoMetro::ClassNameLibrary::StaticDatas::Station
  include ::TokyoMetro::StaticDataModules::GenerateFromHashSetVariable

# @!group クラスメソッド

  # 与えられたハッシュからインスタンスを作成するメソッド
  # @param same_as [String] 作成するインスタンスの ID キー
  # @param h [Hash] ハッシュ
  # @return [Info]
  def self.generate_from_hash( same_as , h , index_in_railway_line = nil )
    ary_of_keys = [ :station_alias , :station_facility , :station_facility_custom , :station_facility_custom_alias ,
      :name_ja , :name_hira , :name_in_system , :name_en , :station_code ,
      :administrator , :other_operator , :stop ,
      :some_trains_stop , :stop_for_drivers ]

    infos = ary_of_keys.map { | key_str |
      generate_from_hash__set_variable( h , key_str )
    }
    self.new( same_as , *infos , index_in_railway_line )
  end

# @!endgroup

  # Constructor
  def initialize( same_as , station_alias , station_facility , station_facility_custom , station_facility_custom_alias ,
      name_ja , name_hira , name_in_system , name_en , station_code , 
      administrator , other_operator , stop ,
      some_trains_stop , stop_for_drivers ,
      index_in_railway_line )
    @same_as = same_as
    @station_alias = station_alias

    @station_facility = station_facility
    @station_facility_custom = station_facility_custom
    @station_facility_custom_alias = station_facility_custom_alias

    @name_ja = name_ja
    @name_hira = name_hira
    @name_in_system = name_in_system
    @name_en = name_en
    @station_code = set_station_code( station_code )
    @index_in_railway_line = index_in_railway_line

    @administrator = administrator
    @other_operator = other_operator

    @stop = stop
    @some_trains_stop = some_trains_stop
    @stop_for_drivers = stop_for_drivers
  end

  # @return [String, ::Array or nil]
  attr_reader :station_alias

  # @return [String]
  attr_reader :station_facility
  # @return [String or nil]
  attr_reader :station_facility_custom
  # @return [String, ::Array or nil]
  attr_reader :station_facility_custom_alias

  # @return [String]
  attr_reader :name_ja
  # @return [String]
  attr_reader :name_hira
  # @return [String]
  attr_reader :name_in_system
  # @return [String]
  attr_reader :name_en

  # @return [String or nil]
  attr_reader :station_code

  # @return [Integer]
  attr_reader :index_in_railway_line

  # @return [String, ::Array or nil]
  attr_reader :administrator
  # @return [String, ::Array or nil]
  attr_reader :other_operator

  # @return [::Array]
  attr_reader :stop
  # @return [::Array or nil]
  attr_reader :some_trains_stop
  # @return [::Array or nil]
  attr_reader :stop_for_drivers

  # インスタンスの比較に用いるメソッド
  # @return [Integer]
  def <=>( other )
    @same_as <=> other.same_as
  end

  # インスタンスの情報を文字列にして返すメソッド
  # @return [String]
  def to_s( indent = 0 )
    str_1 = self.instance_variables.map { |v|
      k = v.to_s.gsub( /\A\@/ , "" ).ljust(32)
      val = self.instance_variable_get(v)

      if val.instance_of?( ::Array )
        val = val.join("／")
      else
        val = val.to_s
      end

      " " * indent + k + val
    }.join( "\n" )

    [ "=" * 96 , str_1 ].join( "\n" )
  end

  # 特定の列車種別の停車駅か否かを判定するメソッド
  # @return [Boolean]
  def stop_of?( train_type )
    @stop.include?( train_type )
  end

  def seed( railway_line_id , indent: 0 )
    if ::Station.exists?( same_as: @same_as )
      seed_update_station( indent )
    else
      if @station_facility.blank?
        raise "Error: #{@station_facility} of \"#{@same_as}\" is not defined."
      end

      seed__find_or_create_facility
      seed_create_station( railway_line_id , station_facility_id )
    end

    seed_to_and_from_station

    # StationAlias , 停車駅の処理
    seed_station_alias
    seed_station_facility_custom

    seed_stopping_patterns
  end

# @!group 駅の ID に関するメソッド

  # @return [String] 駅の ID キー-*
  attr_reader :same_as

# @!endgroup

  private

  def set_station_code( station_code )
    case @same_as
    when "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue"
      "m06"
    else
      station_code
    end
  end

  def seed_update_station( indent )
    info_to_update = ::Station.find_by( same_as: @same_as )
    h = {
      name_hira: @name_hira ,
      name_in_system: @name_in_system ,
      name_en: @name_en ,
      index_in_railway_line: @index_in_railway_line
    }
    info_to_update.update(h)
  end

  def seed_create_station( railway_line_id , station_facility_id )
    h = {
      name_hira: @name_hira ,
      name_in_system: @name_in_system ,
      name_en: @name_en ,
      index_in_railway_line: @index_in_railway_line ,
      #
      name_ja: @name_ja ,
      station_code: @station_code ,
      same_as: @same_as ,
      station_facility_id: station_facility_id ,
      railway_line_id: railway_line_id
    }
    ::Station.create(h)
  end

  def seed__find_or_create_facility
    ::StationFacility.find_or_create_by( same_as: @station_facility )
  end

  def station_in_db
    ::Station.find_by_same_as( @same_as )
  end

  def station_facility_in_db
    ::StationFacility.find_by_same_as( @station_facility )
  end

  def station_id
    _station_in_db = station_in_db
    if _station_in_db.nil?
      raise "Error: \"#{@same_as}\" does not exist in database."
    end
    _station_in_db.id
  end

  def station_facility_id
    station_facility_in_db.id
  end

  def seed_station_alias
    s_id = station_id
    if @station_alias.present?
      [ @station_alias ].flatten.each do | station_alias |
        ::StationAlias.create( station_id: s_id , same_as: station_alias )
      end
    end
  end

  def seed_station_facility_custom
    if @station_facility_custom.present?
      ary_of_station_facility_alias = [ @station_facility_custom ].flatten
      if @station_facility_custom_alias.present?
        ary_of_station_facility_alias += [ @station_facility_custom_alias ].flatten
      end
      sf_id = station_facility_id
      ary_of_station_facility_alias.each.with_index(1) do | station_facility_alias , i |
        h = {
          station_facility_id: sf_id ,
          index_of_alias: i ,
          same_as: station_facility_alias
        }
        ::StationFacilityAlias.create(h)
      end
    end
  end

  def seed_stopping_patterns
    @stop.each do | pattern |
      pattern_id = create_and_get_pattern_id( pattern )
      ::StationStoppingPattern.create( station_id: station_id , stopping_pattern_id: pattern_id , partial: false , for_driver: false )
    end

    if @some_trains_stop.present?
      @some_trains_stop.each do | pattern , note |
        pattern_id = create_and_get_pattern_id( pattern )
        note_id = ::StationStoppingPatternNote.find_or_create_by( text: note ).id
        ::StationStoppingPattern.create( station_id: station_id , stopping_pattern_id: pattern_id , partial: true , for_driver: false , station_stopping_pattern_note_id: note_id )
      end
    end

    if @stop_for_drivers.present?
      @stop_for_drivers.each do | pattern |
        pattern_id = create_and_get_pattern_id( pattern )
        ::StationStoppingPattern.create( station_id: station_id , stopping_pattern_id: pattern_id , partial: false , for_driver: true )
      end
    end

  end

  def create_and_get_pattern_id( pattern )
    ::StoppingPattern.find_or_create_by( same_as: pattern ).id
  end

  def seed_to_and_from_station( _station_id = nil )
    if _station_id.nil?
      _station_id = station_id
    end
  end

end