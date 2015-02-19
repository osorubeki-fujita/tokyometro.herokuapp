class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Reference < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "reference" )
  end

  def self.other_files
    File.join( top_file , "station" )
  end

end