module TokyoMetro::Factory::Seed::Reference::FromAndToStation

  include ::TokyoMetro::Factory::Seed::Reference::Station

  private

  def from_station_in_db( whole = nil , search_by: @info.from_station )
    station_in_db( whole , search_by: search_by )
  end

  def to_station_in_db( whole = nil , search_by: @info.to_station )
    station_in_db( whole , search_by: search_by )
  end

  def from_station_id( whole = nil , search_by: @info.from_station )
    from_or_to_station_id( search_by , whole )
  end

  def to_station_id( whole = nil , search_by: @info.to_station )
    from_or_to_station_id( search_by , whole )
  end

  def from_or_to_station_id( search_by , whole = nil )
    _in_db = station_in_db( whole , search_by: search_by )
    raise "Error: The information (same as \"#{ search_by }\") does not exist in the database." if _in_db.nil?
    _in_db.id
  end

end