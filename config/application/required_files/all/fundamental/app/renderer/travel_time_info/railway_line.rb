class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::TravelTimeInfo::RailwayLine < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "travel_time_info" , "railway_line" )
  end
  
  def self.other_files
    YurakuchoAndFukutoshinLine.files
  end

end