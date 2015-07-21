class BarrierFreeFacility::Info < ActiveRecord::Base

  belongs_to :station_facility_info , class: ::Station::Facility::Info
  belongs_to :type , class: ::BarrierFreeFacility::Type
  belongs_to :located_area , class: ::BarrierFreeFacility::LocatedArea
  belongs_to :remark , class: ::BarrierFreeFacility::Remark

  has_many :root_infos , class: ::BarrierFreeFacility::RootInfo , foreign_key: :info_id
  has_many :place_names , class: ::BarrierFreeFacility::PlaceName , through: :root_infos

  has_many :service_detail_infos , class: ::BarrierFreeFacility::ServiceDetail::Info , foreign_key: :info_id
  has_many :service_detail_patterns , class: ::BarrierFreeFacility::ServiceDetail::Pattern , through: :service_detail_infos

  has_many :escalator_direction_infos , class: ::BarrierFreeFacility::EscalatorDirection::Info , through: :service_detail_infos

  has_many :toilet_assistant_infos , class: ::BarrierFreeFacility::ToiletAssistant::Info , foreign_key: :info_id # 実際の個数は0または1

  has_many :platform_info_barrier_free_facility_infos , class: ::Station::Facility::Platform::BarrierFreeFacilityInfo , foreign_key: :barrier_free_facility_info_id
  has_many :platform_infos , class: ::Station::Facility::Platform::Info , through: :platform_info_barrier_free_facility_infos

  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::LocatedArea

  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::WheelChair::Availability::AliasTowardsAccessibility
  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::WheelChair::Availability::Escalator
  include ::OdptCommon::Modules::Alias::Common::StationFacility::BarrierFree::WheelChair
  include ::OdptCommon::Modules::MethodMissing::Decision::Common::StationFacility::BarrierFree::WheelChair
  include ::OdptCommon::Modules::MethodMissing::Decision::Common::StationFacility::BarrierFree::WheelChair::Availability::Escalator

  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::MobilityScooter::Availability::None
  include ::TokyoMetro::Modules::Decision::Common::StationFacility::BarrierFree::MobilityScooter::Availability::AliasTowardsAccessibility
  include ::OdptCommon::Modules::Alias::Common::StationFacility::BarrierFree::MobilityScooter
  include ::OdptCommon::Modules::MethodMissing::Decision::Common::StationFacility::BarrierFree::MobilityScooter

  ::OdptCommon::Modules::Dictionary::Common::BarrierFree.facility_types.each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }?
        type.send( __method__ )
      end
    DEF
  end

  def toilet_assistant_info_pattern
    _toilet_assistant_infos = toilet_assistant_infos
    if _toilet_assistant_infos.present?
      raise unless _toilet_assistant_infos.length == 1

      _toilet_assistant_infos.first.pattern
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

end
