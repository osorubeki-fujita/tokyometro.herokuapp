class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Generate::Api::StationFacility::Info::Platform::Info < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "generate" , "api" , "station_facility" , "info" , "platform" , "info" )
  end

  def self.other_files
    BarrierFreeAndSurroundingArea.files
  end

end