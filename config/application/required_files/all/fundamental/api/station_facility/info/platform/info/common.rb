class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationFacility::Info::Platform::Info::Common < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: true )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_facility" , "info" , "platform" , "info" , "common" )
  end

end