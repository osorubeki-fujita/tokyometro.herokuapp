class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Api::StationTimetable < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "api" , "station_timetable" )
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