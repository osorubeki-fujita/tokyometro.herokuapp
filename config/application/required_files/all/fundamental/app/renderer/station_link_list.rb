class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::StationLinkList < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_link_list" )
  end

  def self.other_files
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_link_list" , "meta_class" )
  end

end