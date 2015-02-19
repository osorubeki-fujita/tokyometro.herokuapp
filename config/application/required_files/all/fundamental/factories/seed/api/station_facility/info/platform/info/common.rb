class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Api::StationFacility::Info::Platform::Info::Common < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "api" , "station_facility" , "info" , "platform" , "info" , "common" )
  end

  def self.other_files
    ::File.join( top_file , "set_optional_variables" )
  end

end