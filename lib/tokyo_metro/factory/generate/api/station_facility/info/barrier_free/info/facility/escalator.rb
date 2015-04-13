class TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Escalator < TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Escalator

  def variables
    super + [ availability_to_wheel_chair ]
  end

  def self.instance_class
    barrier_free_escalator_info_class
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
    when self.class.spac__is_available_to # == "spac:Wheelchair"
      true
    else
      raise "Error"
    end
  end

  def service_details
    covert_and_set_array_data(
      "odpt:serviceDetail" ,
      self.class.escalator_service_detail_list_class ,
      self.class.escalator_service_detail_info_class
    )
  end

end