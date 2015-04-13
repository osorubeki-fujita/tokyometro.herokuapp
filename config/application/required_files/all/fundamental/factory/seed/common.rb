class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Common < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "common" )
  end

  def self.other_files
    File.join( top_file , "set_optional_variables" )
  end

end