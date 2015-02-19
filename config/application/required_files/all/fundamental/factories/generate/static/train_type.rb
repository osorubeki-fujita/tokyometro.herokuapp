class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Generate::Static::TrainType < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "generate" , "static" , "train_type" )
  end

  def self.other_files
    [ "color" , "custom" ].map { | filename |
      ::File.join( top_file , filename )
    } + [ "other_operator" , "default_setting" , "main" ].map { | namespace |
      files_starting_with( top_file , "custom" , namespace )
    }
  end

end