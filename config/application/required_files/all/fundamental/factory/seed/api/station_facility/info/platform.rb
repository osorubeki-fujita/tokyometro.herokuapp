class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Api::StationFacility::Info::Platform < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "api" , "station_facility" , "info" , "platform" )
  end

  def self.other_files
    Info.files
  end

end