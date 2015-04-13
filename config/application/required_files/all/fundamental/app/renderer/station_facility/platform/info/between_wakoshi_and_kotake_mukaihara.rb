class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::StationFacility::Platform::Info::BetweenWakoshiAndKotakeMukaihara < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_wakoshi_and_kotake_mukaihara" )
  end

  def self.other_files
    [
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_wakoshi_and_kotake_mukaihara" , "common" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_wakoshi_and_kotake_mukaihara" , "whole" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_wakoshi_and_kotake_mukaihara" , "each_direction" )
    ]
  end

end