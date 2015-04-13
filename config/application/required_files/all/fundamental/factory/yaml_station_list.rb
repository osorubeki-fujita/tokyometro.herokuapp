class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::YamlStationList < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "yaml_station_list" )
  end

end