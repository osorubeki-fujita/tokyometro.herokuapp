module TokyoMetro::Factory::Seed::Reference::SurroundingArea

  private

  def surrounding_area_in_db( search_by: @info.area_name )
    ::SurroundingArea.find_or_create_by( name: @info.area_name )
  end

  def surrounding_area_id( search_by: @info.area_name )
    surrounding_area_in_db( search_by: search_by ).id
  end

end