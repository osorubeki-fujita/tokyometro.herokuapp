module TokyoMetro::Modules::Common::Info::StationFacility::BarrierFree

  ::TokyoMetro::Modules::Common::Dictionary::BarrierFree.facility_types.each do | method_base_name |
    eval <<-DEF
      def #{ method_base_name }?
        self.class.#{ method_base_name }?
      end

      def self.#{ method_base_name }?
        category_name_en.underscore == "#{method_base_name}"
      end
    DEF
  end

end