class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationFacility::Info < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_facility" , "info" )
  end

  def self.other_files
    [
      ::Dir.glob( "#{ top_file }/**.rb" ) ,
      BarrierFree.files ,
      Platform.files
    ]
  end

end