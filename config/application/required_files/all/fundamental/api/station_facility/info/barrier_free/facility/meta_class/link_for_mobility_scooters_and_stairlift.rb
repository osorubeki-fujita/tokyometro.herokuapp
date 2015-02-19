class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationFacility::Info::BarrierFree::Facility::MetaClass::LinkForMobilityScootersAndStairLift < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_facility" , "info" , "barrier_free" , "facility" , "meta_class" , "link_for_mobility_scooters_and_stairlift" )
  end

  def self.other_files
    [ "info" , "list" ].map { | filename |
      ::File.join( top_file , filename )
    }
  end

end