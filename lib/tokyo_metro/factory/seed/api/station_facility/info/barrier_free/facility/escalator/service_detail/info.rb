class TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Info < TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info

  private

  def seed_main
    super( get_id: true )
  end

  def seed_optional_infos_for_each_loop
    @info.direction.seed( @id )
  end

end