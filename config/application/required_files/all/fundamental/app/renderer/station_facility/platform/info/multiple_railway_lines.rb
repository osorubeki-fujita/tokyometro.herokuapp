class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::StationFacility::Platform::Info::MultipleRailwayLines < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "multiple_railway_lines" )
  end

  def self.other_files
    [
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "multiple_railway_lines" , "common" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "multiple_railway_lines" , "whole" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "multiple_railway_lines" , "each_direction" )
    ]
  end

end