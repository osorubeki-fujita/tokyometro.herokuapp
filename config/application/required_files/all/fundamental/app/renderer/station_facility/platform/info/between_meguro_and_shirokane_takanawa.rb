class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::StationFacility::Platform::Info::BetweenMeguroAndShirokaneTakanawa < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_meguro_and_shirokane_takanawa" )
  end

  def self.other_files
    [
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_meguro_and_shirokane_takanawa" , "common" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_meguro_and_shirokane_takanawa" , "whole" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" , "between_meguro_and_shirokane_takanawa" , "each_direction" )
    ]
  end

end