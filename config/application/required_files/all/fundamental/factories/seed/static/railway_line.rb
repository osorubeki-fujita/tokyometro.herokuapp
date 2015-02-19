class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Static::RailwayLine < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "static" , "railway_line" )
  end

end