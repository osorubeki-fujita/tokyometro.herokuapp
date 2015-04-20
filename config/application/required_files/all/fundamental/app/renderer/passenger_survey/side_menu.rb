class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::PassengerSurvey::SideMenu < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "passenger_survey" , "side_menu" )
  end
  
  def self.other_files
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "passenger_survey" , "side_menu" , "meta_class" )
  end

end