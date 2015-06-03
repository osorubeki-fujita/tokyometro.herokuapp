class BarrierFreeFacility::Info < ActiveRecord::Base

  belongs_to :station_facility_info , class: ::StationFacility::Info
  belongs_to :barrier_free_facility_type , class: ::BarrierFreeFacilityType
  belongs_to :barrier_free_facility_located_area , class: ::BarrierFreeFacilityLocatedArea

  has_many :barrier_free_facility_root_infos , class: ::BarrierFreeFacilityRootInfo , foreign_key: :barrier_free_facility_info_id
  has_many :barrier_free_facility_place_names , class: ::BarrierFreeFacilityPlaceName , through: :barrier_free_facility_root_infos

  has_many :barrier_free_facility_service_details , class: ::BarrierFreeFacilityServiceDetail , foreign_key: :barrier_free_facility_info_id
  has_many :barrier_free_facility_service_detail_patterns , class: ::BarrierFreeFacilityServiceDetailPattern , through: :barrier_free_facility_service_details

  has_many :barrier_free_facility_escalator_directions , class: ::BarrierFreeFacilityEscalatorDirection , through: :barrier_free_facility_service_details

  has_many :barrier_free_facility_toilet_assistants , class: ::BarrierFreeFacilityToiletAssistant , foreign_key: :barrier_free_facility_info_id # 実際の個数は0または1
  has_many :barrier_free_facility_toilet_assistant_patterns , class: ::BarrierFreeFacilityToiletAssistantPattern , through: :barrier_free_facility_toilet_assistants

  has_many :station_facility_platform_info_barrier_free_facility_infos , class: ::StationFacilityPlatformInfoBarrierFreeFacilityInfo , foreign_key: :barrier_free_facility_info_id
  has_many :station_facility_platform_infos , class: ::StationFacilityPlatformInfo

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::LocatedArea

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::WheelChair::Availability::AliasTowardsAccessibility
  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::WheelChair::MethodMissing

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::WheelChair::Availability::Escalator

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::MobilityScooter::Availability::None
  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::MobilityScooter::Availability::AliasTowardsAccessibility
  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::MobilityScooter::MethodMissing

  ::TokyoMetro::Modules::Common::Dictionary::BarrierFree.facility_types.each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }?
        barrier_free_facility_type.send( __method__ )
      end
    DEF
  end

  def root_infos
    barrier_free_facility_root_infos.includes( :barrier_free_facility_place_name )
  end

  [
    :type , :located_area , :place_names ,
    :service_details , :service_detail_patterns , :escalator_directions , :escalator_direction_patterns ,
    :toilet_assistants , :toilet_assistant_patterns
  ].each do | method_name |
    eval <<-DEF
      def #{method_name}
        barrier_free_facility_#{method_name}
      end
    DEF
  end

  def toilet_assistant_info_pattern
    _toilet_assistant_patterns = toilet_assistant_patterns
    if _toilet_assistant_patterns.present?
      unless _toilet_assistant_patterns.length == 1
        raise "Error"
      end
      _toilet_assistant_patterns.first
    else
      nil
    end
  end

  [ :name_ja , :name_en ].each do | method_base_name |
    eval <<-DEF
      def located_area_#{ method_base_name }
        located_area.#{ method_base_name }
      end
    DEF
  end

  def barrier_free_facility_toilet_assistant_pattern
    _patterns = barrier_free_facility_toilet_assistant_patterns
    if _patterns.present?
      if _patterns.length > 2
        raise "Error"
      end
      _patterns.first
    else
      nil
    end
  end

end
