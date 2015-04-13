module TokyoMetro::Factory::Seed::Reference::RailwayDirection

  private

  def railway_direction_in_db( _railway_line_id = railway_line_id , whole = nil , search_by: @info.railway_direction )
    if whole.present?
      whole.find_by( railway_line_id: _railway_line_id , in_api_same_as: search_by )
    else
      ::RailwayDirection.find_by( railway_line_id: _railway_line_id , in_api_same_as: search_by )
    end
  end

  def railway_direction_id( _railway_line_id = railway_line_id , whole = nil , search_by: @info.railway_direction )
    # _railway_direction_in_db = railway_direction_in_db( _railway_line_id , whole , search_by: search_by )
    # if _railway_direction_in_db.nil?
        # raise "Error: The railway direction \'#{search_by}\' of \'#{ ::RailwayLine.find_by( _railway_line_id ).same_as }\' is not defined."
    # end
    # _railway_direction_in_db.id
    railway_direction_in_db( _railway_line_id , whole , search_by: search_by ).id
  end

end