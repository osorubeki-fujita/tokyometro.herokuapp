class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::StationFacility < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" )
  end
  
  def self.other_files
    Platform.files
  end

end