class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationFacility::Info::BarrierFree < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: true )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_facility" , "info" , "barrier_free" )
  end

  def self.other_files
    [
      ::File.join( top_file , "info" ) ,
      ::Dir.glob( "#{ top_file }/**.rb" ).sort ,
      ServiceDetail.files ,
      Facility.files
    ]
  end

end