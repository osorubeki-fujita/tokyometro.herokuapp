class TokyoMetro::Factory::Seed::Static::RailwayDirection::Info < TokyoMetro::Factory::Seed::Static::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Static::RailwayDirection

  include ::TokyoMetro::Factory::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factory::Seed::Reference::Station

  private

  def hash_to_db
    { 
      same_as: @info.same_as ,
      in_api_same_as: @info.in_api_same_as ,
      railway_direction_code: @info.railway_direction_code ,
      railway_line_id: railway_line_id ,
      station_id: station_id
    }
  end

  def railway_line_in_db( whole = nil , search_by: @info.railway_line )
    _railway_line_in_db = super( whole = nil , search_by: search_by )
    if _railway_line_in_db.nil?
      puts "\"#{ @info.railway_line }\" does not exist in db."
      _railway_line_in_db = super( whole = nil , search_by: "Undefined" )
      if _railway_line_in_db.nil?
        raise "Error: \"Undefined\" does not exist in db."
      end
    end
    _railway_line_in_db
  end

  def station_in_db( whole = nil , search_by: @info.station )
    _station_in_db = super( whole = nil , search_by: search_by )
    if _station_in_db.nil?
      puts "\"#{ @info.station }\" does not exist in db."
      _station_in_db = super( whole = nil , search_by: "Undefined" )
      if _station_in_db.nil?
        raise "Error: \"Undefined\" does not exist in db."
      end
    end
    _station_in_db
  end

end