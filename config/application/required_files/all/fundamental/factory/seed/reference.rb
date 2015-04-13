class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Reference < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "reference" )
  end

  def self.other_files
    File.join( top_file , "station" )
  end

end