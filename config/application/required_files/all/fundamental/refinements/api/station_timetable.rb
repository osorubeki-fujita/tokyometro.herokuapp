class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Refinements::Api::StationTimetable < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "refinements" , "api" , "station_timetable" )
  end

  def self.other_files
    [
      [ "info" ] ,
      [ "info" , "fundamental" ] ,
      [ "info" , "fundamental" , "info" ] ,
      [ "info" , "fundamental" , "list" ]
    ].map { | filename |
      File.join( top_file , *filename )
    }
  end

end