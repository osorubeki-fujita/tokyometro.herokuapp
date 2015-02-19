class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Generate::Api::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "generate" , "api" , "meta_class" )
  end

  def self.other_files
    [
      [ "info" ] ,
      [ "info" , "fundamental" ] ,
      [ "info" , "not_on_the_top_layer" ] ,
      [ "list" ] ,
      [ "list" , "normal" ] ,
      [ "list" , "date" ]
    ].map { | file_basename |
      ::File.join( top_file , *file_basename )
    }
  end

end