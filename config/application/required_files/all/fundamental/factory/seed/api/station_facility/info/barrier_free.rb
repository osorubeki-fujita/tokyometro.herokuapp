class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Api::StationFacility::Info::BarrierFree < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "api" , "station_facility" , "info" , "barrier_free" )
  end

  def self.other_files
    [
      ::File.join( top_file , "info" ) ,
      ServiceDetail.files ,
      ::File.join( top_file , "list" )
    ]
  end

end