class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::Concern::Header::Title < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "concern" , "header" , "title" )
  end
  
  def self.other_files
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "concern" , "header" , "title" , "meta_class" )
  end

end