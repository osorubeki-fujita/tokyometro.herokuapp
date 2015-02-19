class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationTimetable::Info < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_timetable" , "info" )
  end

  def self.other_files
    [
      ::File.join( top_file , "hash" ) ,
      TrainTime.files
    ]
  end

end