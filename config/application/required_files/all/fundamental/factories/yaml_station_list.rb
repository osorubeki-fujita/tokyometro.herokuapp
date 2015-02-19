class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::YamlStationList < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "yaml_station_list" )
  end

end