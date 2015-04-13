class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App::Renderer::StationFacility::Platform::Info < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" , "renderer" , "station_facility" , "platform" , "info" )
  end

  def self.other_files
    [
      MetaClass.files ,
      Normal.files ,
      MultipleRailwayLines.files ,
      BetweenMeguroAndShirokaneTakanawa.files ,
      BetweenWakoshiAndKotakeMukaihara.files
    ]
  end

end