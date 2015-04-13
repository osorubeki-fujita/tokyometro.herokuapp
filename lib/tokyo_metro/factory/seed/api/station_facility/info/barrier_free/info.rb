class TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::Common::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::RailwayDirection

  def initialize( *args )
    super( *args )
  end

  private

  def hash_to_db
    {
      station_facility_id: @station_facility_id ,
      id_urn: @info.id_urn ,
      same_as: @info.same_as ,
      remark: @info.remark ,
      barrier_free_facility_located_area_id: barrier_free_facility_located_area_id ,
      barrier_free_facility_type_id: barrier_free_facility_type_id
    }
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_barrier_free_facility_info
  end

  def barrier_free_facility_located_area_id
    ::BarrierFreeFacilityLocatedArea.find_or_create_by( name_ja: @info.located_area_name_ja , name_en: @info.located_area_name_en ).id
  end

  def barrier_free_facility_type_id
    ::BarrierFreeFacilityType.find_or_create_by(
      name_ja: @info.class.category_name ,
      name_en: @info.class.category_name_en
    ).id
  end

  def seed_optional_infos
    seed_place_name_info
    seed_service_detail
  end

  def seed_place_name_info
    if @info.place_name.present?
      ary = @info.place_name.split( "～" )

      case ary.length
      when 1
        place_name = ary.first
        seed_barrier_free_facility_root_info( place_name , 0 )
      else
        ary.each.with_index(1) do | place_name , i |
          seed_barrier_free_facility_root_info( place_name , i )
        end
      end

    end
  end

  # service_detail の流し込み
  def seed_service_detail
    @info.send( :seed_service_detail , @id )
  end

  def seed_barrier_free_facility_root_info( place_name , i )
    ::BarrierFreeFacilityRootInfo.find_or_create_by(
      barrier_free_facility_id: @id ,
      barrier_free_facility_place_name_id: place_name_id( place_name ) ,
      index_in_root: i
    )
  end

  def place_name_id( place_name )
    ::BarrierFreeFacilityPlaceName.find_or_create_by( name_ja: place_name.zen_num_to_han ).id
  end

end