module TokyoMetro::Factory::Seed::Reference::StationFacility

  private

  def station_facility_in_db( whole = nil , search_by: @info.facility )
    if whole.present?
      whole.find_by_same_as( search_by )
    else
      ::StationFacility.find_by_same_as( search_by )
    end
  end

  def station_facility_id( whole = nil , search_by: @info.facility )
    _station_facility_in_db = station_facility_in_db( whole , search_by: search_by )
    raise "Error: \"#{ search_by }\" does not exist in the database." if _station_facility_in_db.nil?
    _station_facility_in_db.id
  end

end