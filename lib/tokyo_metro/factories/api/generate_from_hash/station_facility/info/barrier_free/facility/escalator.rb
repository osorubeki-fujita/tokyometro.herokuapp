class TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree::Facility::Escalator < TokyoMetro::Factories::Api::GenerateFromHash::StationFacility::Info::BarrierFree

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  def variables
    [ super , availability_to_wheel_chair ].flatten(1)
  end

  private

  def variables__check__separation
    "="
  end

  def variables__check__letter
    "●"
  end

  def availability_to_wheel_chair
    case @hash[ "spac:isAvailableTo" ]
    when nil
      false
    when self.class.info_class.spac__is_available_to # == "spac:Wheelchair"
      true
    else
      raise "Error"
    end
  end

end