class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Common < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "common" )
  end

  def self.other_files
    File.join( top_file , "set_optional_variables" )
  end

end