module TokyoMetro::Factory::Seed::Reference::Point

  private

  def point_in_db( whole = nil , search_by: @info.point )
    if whole.present?
      whole.find_by_id_urn( search_by )
    else
      ::Point.find_by_id_urn( search_by )
    end
  end

  def point_id( whole = nil , search_by: @info.point )
    _point_in_db = point_in_db( whole , search_by: search_by )
    raise "Error: \"#{ search_by }\" does not exist in the database." if _point_in_db.nil?
    _point_in_db.id
  end

  alias :exit_in_db :point_in_db
  alias :exit_id :point_id

end