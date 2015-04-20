class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::PassengerSurvey::Table < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "passenger_survey" , "table" )
  end
  
  def self.other_files
    MetaClass.files
  end

end