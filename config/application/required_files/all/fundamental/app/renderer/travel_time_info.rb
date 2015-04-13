class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::TravelTimeInfo < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "travel_time_info" )
  end
  
  def self.other_files
    [ MetaClass.files , RailwayLine.files ]
  end

end