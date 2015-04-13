class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Seed::Api::Station < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "seed" , "api" , "station" )
  end

  def self.other_files
    [
      [ "common" ] ,
      [ "info" ] ,
      [ "info" , "common" ] ,
      [ "info" , "common" , "optional_variables" ]
    ].map { | dir_name |
      ::File.join( top_file , *dir_name )
    }
  end

end