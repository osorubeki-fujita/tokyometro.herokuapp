class BarrierFreeFacility < ActiveRecord::Base

  belongs_to :station_facility
  belongs_to :barrier_free_facility_type
  belongs_to :barrier_free_facility_located_area

  has_many :barrier_free_facility_root_infos
  has_many :barrier_free_facility_place_names , through: :barrier_free_facility_root_infos
  
  has_many :barrier_free_facility_service_details
  has_many :barrier_free_facility_service_detail_patterns , through: :barrier_free_facility_service_details
  has_many :barrier_free_facility_escalator_directions , through: :barrier_free_facility_service_details

  has_many :barrier_free_facility_toilet_assistants # 実際の個数は0または1
  has_many :barrier_free_facility_toilet_assistant_patterns , through: :barrier_free_facility_toilet_assistants

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
    :service_details , :service_detail_patterns , :escalator_directions ,
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

end