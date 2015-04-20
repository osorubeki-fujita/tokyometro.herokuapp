class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::PassengerSurvey < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "passenger_survey" )
  end
  
  def self.other_files
    SideMenu.files
  end

end