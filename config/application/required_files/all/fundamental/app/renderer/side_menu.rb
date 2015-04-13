class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::SideMenu < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "side_menu" )
  end

  def self.other_files
    [
      Link.files ,
      NowDeveloping.files
    ]
  end

end