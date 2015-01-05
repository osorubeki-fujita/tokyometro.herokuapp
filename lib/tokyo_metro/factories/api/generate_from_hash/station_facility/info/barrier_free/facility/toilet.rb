class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Toilet < TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Toilet

  def variables
    [ super , has_assistant ].flatten(1)
  end

  private

  def has_assistant
    ary = @hash[ "spac:hasAssistant" ]
    if ary.blank?
      nil
    else
      self.class.assinstant_class.generate_from_array( ary )
    end
  end

end