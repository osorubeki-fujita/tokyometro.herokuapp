class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" )
  end

  def self.other_files
    [
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "meta_class" ) ,
      Concern.files ,
      Document.files ,
      SideMenu.files ,
      Twitter.files ,
      StationLinkList.files ,
      StationFacility.files ,
      TravelTimeInfo.files
    ]
  end

end