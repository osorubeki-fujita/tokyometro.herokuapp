class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Api::StationTimetable < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "api" , "station_timetable" )
  end

  def self.other_files
    [
      [ "common" ] ,
      [ "info" ] ,
      [ "info" , "fundamental" ] ,
      [ "info" , "fundamental" , "common" ] ,
      [ "info" , "fundamental" , "list" ]
    ].map { | dirname |
      File.join( top_file , *dirname )
    }
  end

end