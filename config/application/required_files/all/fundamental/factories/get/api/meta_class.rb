class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Get::Api::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "get" , "api" , "meta_class" )
  end

  def self.other_files
    [ "fundamental" , "data_search" , "geo" ].map { | filename |
      ::File.join( top_file , filename )
    }
  end

end