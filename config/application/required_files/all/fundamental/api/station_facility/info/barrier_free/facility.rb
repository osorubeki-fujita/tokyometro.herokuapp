class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationFacility::Info::BarrierFree::Facility < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_facility" , "info" , "barrier_free" , "facility" )
  end

  def self.other_files
    MetaClass.files
  end

end