class BarrierFreeFacility::EscalatorDirection::Info < ActiveRecord::Base

  belongs_to :service_detail_info , class: ::BarrierFreeFacility::ServiceDetail::Info
  belongs_to :pattern , class: ::BarrierFreeFacility::EscalatorDirection::Pattern

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::Escalator::ServiceDetail::Direction

  [ :up , :down ].each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }
        pattern.#{ method_base_name }
      end
    DEF
  end

end
