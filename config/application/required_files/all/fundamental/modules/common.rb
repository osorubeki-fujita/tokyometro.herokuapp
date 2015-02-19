class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Modules::Common < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "modules" , "common" )
  end

  def self.other_files
    [
      File.join( "#{ top_file }/convert_constant_to_class_method" ) ,
      File.join( "#{ top_file }/dictionary" ) ,
      [ "railway_line" , "station" ].map { | dictionary_type |
        [
          File.join( top_file , "dictionary" , dictionary_type ) ,
          [ "string_info" , "string_list" , "regexp_info" ].map { | namespace |
            File.join( top_file , "dictionary" , dictionary_type , namespace )
          }
        ]
      } ,
      File.join( top_file , "decision" ) ,
      files_starting_with( top_file , "decision" , "station_regexp_library" )
    ]
  end

end