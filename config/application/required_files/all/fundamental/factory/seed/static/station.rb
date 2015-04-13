class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Static::Station < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "static" , "station" )
  end

  def self.other_files
    ::File.join( top_file , "optional_variables" )
  end

end