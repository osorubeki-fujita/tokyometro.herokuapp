class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Static::Station < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "static" , "station" )
  end

  def self.other_files
    ::File.join( top_file , "optional_variables" )
  end

end