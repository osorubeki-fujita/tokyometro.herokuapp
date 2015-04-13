class TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Info

  private

  def seed_optional_infos
    super
    seed_assistant_facility_info
  end

  def seed_assistant_facility_info
    @info.assistant_facility.try( :seed , @id )
  end

end