class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::Concern::Header < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "concern" , "header" )
  end
  
  def self.other_files
    [
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "concern" , "header" , "meta_class" ) ,
      Title.files ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "concern" , "header" , "content" )
    ]
  end

end