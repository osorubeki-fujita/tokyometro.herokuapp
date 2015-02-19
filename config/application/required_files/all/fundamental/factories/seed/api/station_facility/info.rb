class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Api::StationFacility::Info < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "api" , "station_facility" , "info" )
  end

  def self.other_files
    [ Common.files , BarrierFree.files , Platform.files ]
  end

end