# 個別の施設・出口情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::Platform::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Modules::Common::ToFactory::Generate::Info
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  include ::TokyoMetro::Modules::Common::Info::Decision::CompareBase
  include ::TokyoMetro::Modules::Api::Info::Decision::RailwayLine

  include ::TokyoMetro::Modules::Api::Info::ToStringGeneral
  include ::TokyoMetro::Modules::Api::Info::SetDataToHash

  # Constructor
  def initialize( railway_line , car_composition , car_number , railway_direction , transfer_infos , barrier_free_facilities , surrounding_areas )
    # puts "#{self.class.name}\#initialize: \@railway_line \: #{railway_line.to_s}"
    unless transfer_infos.nil? or transfer_infos.instance_of?( self.class.platform_transfer_list_class )
      raise "Error: #{transfer_infos.class.name} is not valid."
    end
    unless barrier_free_facilities.nil? or barrier_free_facilities.instance_of?( self.class.platform_barrier_free_list_class )
      raise "Error: #{barrier_free_facilities.class.name} is not valid."
    end
    unless surrounding_areas.nil? or surrounding_areas.instance_of?( self.class.platform_surrounding_area_list_class )
      raise "Error: #{surrounding_areas.class.name} is not valid."
    end

    @railway_line = railway_line
    @car_composition = car_composition
    @car_number = car_number
    @railway_direction = railway_direction
    @transfer_infos = transfer_infos
    @barrier_free_facilities = barrier_free_facilities
    @surrounding_areas = surrounding_areas
  end

  attr_reader :railway_line

  # @return [Integer] 車両編成数
  attr_reader :car_composition

  # @return [Integer] 車両の号車番号
  attr_reader :car_number

  # @return [String] プラットフォームに停車する列車の方面
  attr_reader :railway_direction

  # @return [Transfer::List <Transfer>] 最寄りの乗り換え可能な路線と所要時間
  attr_reader :transfer_infos

  # @return [::Array <String>] 最寄りのバリアフリー施設
  attr_reader :barrier_free_facilities

  # @return [::Array <String>] 改札外の最寄り施設
  attr_reader :surrounding_areas

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "odpt:railway" , @railway_line )
    set_data_to_hash( h , "odpt:carComposition" , @car_composition )
    set_data_to_hash( h , "odpt:carNumber" , @car_number )
    set_data_to_hash( h , "odpt:railDirection" , @railway_direction )
    set_data_to_hash( h , "odpt:transferInformation" , @transfer_infos )
    set_data_to_hash( h , "odpt:barrierfreeFacility" , @barrier_free_facilities )
    set_data_to_hash( h , "odpt:surroundingArea" , @surrounding_areas )

    h
  end

  alias :to_strf :to_s

  def seed( station_facility_id )
    super( station_facility_id )
  end

  [ :transfer_infos , :barrier_free_facilities , :surrounding_areas ].each do | method_base_name |
    eval <<-DEF
      def seed_#{ method_base_name }( station_facility_platform_info_id )
        @#{ method_base_name }.try( :seed , station_facility_platform_info_id )
      end
      private :seed_#{ method_base_name }
    DEF
  end

  def self.factory_for_generating_from_hash
    factory_for_generating_platform_info_from_hash
  end

  def self.factory_for_seeding_this_class
    factory_for_seeding_platform_info
  end

end