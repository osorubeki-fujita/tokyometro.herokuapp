class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::Concern < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "concern" )
  end
  
  def self.other_files
    Header.files
  end

end