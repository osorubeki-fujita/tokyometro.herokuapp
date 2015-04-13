class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Save::Api::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "save" , "api" , "meta_class" )
  end

  def self.other_files
    [
      [ "each_file" ] ,
      [ "each_file" , "fundamental" ] ,
      [ "each_file" , "data_search" ] ,
      [ "group" ] ,
      [ "group" , "file_info" ] ,
      [ "group" , "list" ]
    ].map { | filename |
      ::File.join( top_file , *filename )
    } + files_starting_with( top_file , "group" , "file_info" )
  end

end