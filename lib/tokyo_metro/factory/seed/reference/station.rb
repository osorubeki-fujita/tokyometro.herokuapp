module TokyoMetro::Factory::Seed::Reference::Station

  private

  def station_in_db( whole = nil , search_by: @info.station )
    if whole.present?
      whole.find_by_same_as( search_by )
    else
      ::Station.find_by_same_as( search_by )
    end
  end

  def station_id( whole = nil , search_by: @info.station )
    _station_in_db = station_in_db( whole , search_by: search_by )
    raise "Error: \"#{ search_by }\" does not exist in the database." if _station_in_db.nil?
    _station_in_db.id
  end

end