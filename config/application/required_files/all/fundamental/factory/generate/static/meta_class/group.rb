class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Generate::Static::MetaClass::Group < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "generate" , "static" , "meta_class" , "group" )
  end

  def self.other_files
    [ "fundamental" , "multiple_yamls" , "hash_in_hash" ].map { | filename |
      files_starting_with( top_file , filename )
    }
  end

end