module TokyoMetro::Factory::Seed::Reference::DcDate

  private

  def dc_date( create_from: @info.dc_date )
    ::Time.new( create_from.year , create_from.month , create_from.day , create_from.hour , create_from.min , create_from.sec , create_from.zone )
  end

end