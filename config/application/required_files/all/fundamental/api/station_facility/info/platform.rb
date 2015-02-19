class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationFacility::Info::Platform < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: true )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_facility" , "info" , "platform" )
  end

  def self.other_files
    Info.files
  end

end