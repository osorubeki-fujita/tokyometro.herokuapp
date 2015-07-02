class BarrierFreeFacilityLocatedArea < ActiveRecord::Base

  has_many :barrier_free_facility_infos

  include ::TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree::LocatedArea

  [ :name_ja , :name_en ].each do | method_base_name |
    eval <<-DEF
      def located_area_#{ method_base_name }
        #{ method_base_name }
      end
    DEF
  end

end