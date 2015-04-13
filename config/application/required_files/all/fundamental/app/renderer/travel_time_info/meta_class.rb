class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::TravelTimeInfo::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "travel_time_info" , "meta_class" )
  end
  
  def self.other_files
    [
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "travel_time_info" , "meta_class" , "columns" ) ,
      ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "travel_time_info" , "meta_class" , "common" )
    ]
  end

end