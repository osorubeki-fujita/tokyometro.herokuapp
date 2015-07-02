class BarrierFreeFacilityEscalatorDirection < ActiveRecord::Base

  belongs_to :barrier_free_facility_service_detail
  belongs_to :barrier_free_facility_escalator_direction_pattern

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

  [ :service_detail , :escalator_direction_pattern ].each do | method_name |
    eval <<-DEF
      def #{ method_name }
        barrier_free_facility_#{ method_name }
      end
    DEF
  end

  def pattern
    escalator_direction_pattern
  end

  [ :up , :down ].each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }
        pattern.#{ method_base_name }
      end
    DEF
  end

end
