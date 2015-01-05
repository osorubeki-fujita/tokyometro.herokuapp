# 個別の施設・出口情報を扱うクラス
class TokyoMetro::Api::StationFacility::Info::Platform::Info

  include ::TokyoMetro::ApiModules::Decision::RailwayLine

  # Constructor
  def initialize( railway_line , car_composition , car_number , railway_direction , transfer_informations , barrier_free_facilities , surrounding_areas )
    # puts "#{self.class.name}\#initialize: \@railway_line \: #{railway_line.to_s}"
    unless transfer_informations.nil? or transfer_informations.instance_of?( ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer::List )
      raise "Error: #{transfer_informations.class.name} is not valid."
    end
    unless barrier_free_facilities.nil? or barrier_free_facilities.instance_of?( ::Array )
      raise "Error: #{barrier_free_facilities.class.name} is not valid."
    end
    unless surrounding_areas.nil? or surrounding_areas.instance_of?( ::Array )
      raise "Error: #{surrounding_areas.class.name} is not valid."
    end

    @railway_line = railway_line
    @car_composition = car_composition
    @car_number = car_number
    @railway_direction = railway_direction
    @transfer_informations = transfer_informations
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
  attr_reader :transfer_informations

  # @return [::Array <String>] 最寄りのバリアフリー施設
  attr_reader :barrier_free_facilities

  # @return [::Array <String>] 改札外の最寄り施設
  attr_reader :surrounding_areas

  include ::TokyoMetro::ApiModules::ToFactoryClass::GenerateFromHash
  include ::TokyoMetro::ApiModules::InstanceMethods::ToStringGeneral
  include ::TokyoMetro::ApiModules::InstanceMethods::SetDataToHash

  # インスタンスの情報をハッシュにして返すメソッド
  # @return [Hash]
  def to_h
    h = Hash.new

    set_data_to_hash( h , "odpt:railway" , @railway_line )
    set_data_to_hash( h , "odpt:carComposition" , @car_composition )
    set_data_to_hash( h , "odpt:carNumber" , @car_number )
    set_data_to_hash( h , "odpt:railDirection" , @railway_direction )
    set_data_to_hash( h , "odpt:transferInformation" , @transfer_informations )
    set_data_to_hash( h , "odpt:barrierfreeFacility" , @barrier_free_facilities )
    set_data_to_hash( h , "odpt:surroundingArea" , @surrounding_areas )

    h
  end

  alias :to_strf :to_s

  def seed( station_facility_id , indent: 0 )
    ayase , ayase_chiyoda_main , ayase_chiyoda_branch = seed__ayase( station_facility_id )
    unless ayase_chiyoda_branch
      railway_line_id = ::RailwayLine.find_by_same_as( @railway_line ).id
      railway_direction_h = {
        railway_line_id: railway_line_id ,
        in_api_same_as: @railway_direction
      }
    else
      railway_line_id = ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.ChiyodaBranch" ).id
      railway_direction_h = {
        railway_line_id: ::RailwayLine.find_by_same_as( @railway_line ).id ,
        in_api_same_as: @railway_direction
      }
    end

    railway_direction_in_db = ::RailwayDirection.find_by( railway_direction_h )
    raise "Error" if railway_direction_in_db.nil?
    seed_h = {
      station_facility_id: station_facility_id ,
      railway_line_id: railway_line_id ,
      railway_direction_id: railway_direction_in_db.id ,
      car_composition: @car_composition ,
      car_number: @car_number
    }
    ::StationFacilityPlatformInfo.create( seed_h )
    new_station_facility_platform_info_id = ::StationFacilityPlatformInfo.find_by( seed_h ).id

    unless new_station_facility_platform_info_id.kind_of?( ::Integer )
      raise "Error: #{new_station_facility_platform_info_id.class.name} is not valid."
    end

    seed_transfer_informations( new_station_facility_platform_info_id , indent: indent )
    seed_barrier_free_facilities( new_station_facility_platform_info_id )
    seed_surrounding_areas( new_station_facility_platform_info_id )
  end

  def seed__ayase( station_facility_id )
    ayase = StationFacility.find_by_id( station_facility_id ).stations.where( same_as: "odpt.Station:TokyoMetro.Chiyoda.Ayase" ).present?
    ayase_chiyoda_main = nil
    ayase_chiyoda_branch = nil
    if ayase 
      case @car_composition
      when 3
        ayase_chiyoda_branch = true
      when 10
        ayase_chiyoda_main = true
      else
        raise "Error"
      end
    end
    [ ayase , ayase_chiyoda_main , ayase_chiyoda_branch ]
  end

  def seed_transfer_informations( new_station_facility_platform_info_id , indent: 0 )
    unless @transfer_informations.nil? or @transfer_informations.instance_of?( ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer::List )
      raise "Error"
    end
    # @transfer_informations は nil の場合があることに注意
    if @transfer_informations.present?
      @transfer_informations.seed( new_station_facility_platform_info_id , indent: indent + 1 )
    end
  end

  def seed_barrier_free_facilities( new_station_facility_platform_info_id , indent: 0 )
    if @barrier_free_facilities.instance_of?( ::Array ) and !( @barrier_free_facilities.empty? )
      #-------- each ここから
      @barrier_free_facilities.each do | facility_name |

        if ::BarrierFreeFacility.exists?( same_as: facility_name )
          instance_in_db = ::BarrierFreeFacility.find_by( same_as: facility_name )

          seed_h = {
            station_facility_platform_info_id: new_station_facility_platform_info_id ,
            barrier_free_facility_id: instance_in_db.id
          }
          ::StationFacilityPlatformInfoBarrierFreeFacility.create( seed_h )
        else
          str = "Error: The barrier free facility \"#{facility_name}\" does not exist in the database."
          puts str
          # raise str
        end

      end
      #-------- each ここまで
    end
  end

  def seed_surrounding_areas( new_station_facility_platform_info_id , indent: 0 )
    if @surrounding_areas.instance_of?( ::Array ) and !( @surrounding_areas.empty? )

      @surrounding_areas.each do | area |
        ::SurroundingArea.find_or_create_by( name: area )
      end

      @surrounding_areas.each do | area |
        ::StationFacilityPlatformInfoSurroundingArea.create(
          station_facility_platform_info_id: new_station_facility_platform_info_id ,
          surrounding_area_id: ::SurroundingArea.find_by( name: area ).id
        )
      end

    end

  end

  def self.factory_for_generating_from_hash
    ::TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::Platform::Info
  end

end