class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::SideMenu::Link < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "side_menu" , "link" )
  end

  def self.other_files
    MetaClass.files
  end

end