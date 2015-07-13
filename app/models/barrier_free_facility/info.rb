class BarrierFreeFacility::Info < ActiveRecord::Base

  belongs_to :station_facility_info , class: ::StationFacility::Info
  belongs_to :type , class: ::BarrierFreeFacility::Type
  belongs_to :located_area , class: ::BarrierFreeFacility::LocatedArea

  has_many :root_infos , class: ::BarrierFreeFacility::RootInfo , foreign_key: :info_id
  has_many :place_names , class: ::BarrierFreeFacility::PlaceName , through: :root_infos

  has_many :service_detail_infos , class: ::BarrierFreeFacility::ServiceDetail::Info , foreign_key: :info_id
  has_many :service_detail_patterns , class: ::BarrierFreeFacility::ServiceDetail::Pattern , through: :service_detail_infos

  has_many :escalator_direction_infos , class: ::BarrierFreeFacility::EscalatorDirection::Info , through: :service_detail_infos

  has_many :toilet_assistant_infos , class: ::BarrierFreeFacility::ToiletAssistant::Info , foreign_key: :info_id # 実際の個数は0または1
  has_many :toilet_assistant_patterns , class: ::BarrierFreeFacility::ToiletAssistant::Pattern , through: :toilet_assistant_infos

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
        type.send( __method__ )
      end
    DEF
  end

  def toilet_assistant_info_pattern
    _toilet_assistant_patterns = toilet_assistant_patterns
    if _toilet_assistant_patterns.present?
      raise unless _toilet_assistant_patterns.length == 1

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
