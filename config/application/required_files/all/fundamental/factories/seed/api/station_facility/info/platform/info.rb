class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Api::StationFacility::Info::Platform::Info < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "api" , "station_facility" , "info" , "platform" , "info" )
  end

  def self.other_files
    Common.files
  end

end