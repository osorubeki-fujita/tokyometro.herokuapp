class TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Toilet < TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility::BarrierFree::Toilet

  def variables
    super + [ has_assistant ]
  end

  def self.instance_class
    barrier_free_toilet_info_class
  end

  private

  def has_assistant
    ary = @hash[ "spac:hasAssistant" ]
    if ary.blank?
      nil
    else
      self.class.barrier_free_toilet_assinstant_class.generate_from_hash( ary )
    end
  end

end