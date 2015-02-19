class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::RailwayLine < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "railway_line" )
  end

end