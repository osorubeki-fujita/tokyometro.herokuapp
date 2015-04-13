class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Api::StationFacility < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "api" , "station_facility" )
  end

  def self.other_files
    [ List.files , Info.files ]
  end

end