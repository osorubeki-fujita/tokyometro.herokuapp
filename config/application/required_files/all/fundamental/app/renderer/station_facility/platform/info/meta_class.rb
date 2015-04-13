class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::StationFacility::Platform::Info::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "meta_class" )
  end

  def self.other_files
    [
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "meta_class" , "common" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "meta_class" , "whole" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "meta_class" , "each_direction" ) ,
      TableRow.files
    ]
  end

end