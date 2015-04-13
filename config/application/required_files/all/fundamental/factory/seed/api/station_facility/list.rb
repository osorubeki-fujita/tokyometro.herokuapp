class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Api::StationFacility::List < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "api" , "station_facility" , "list" )
  end

  def self.other_files
    ::File.join( top_file , "common" )
  end

end