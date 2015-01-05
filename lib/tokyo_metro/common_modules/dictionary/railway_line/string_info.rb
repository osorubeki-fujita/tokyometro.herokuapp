module TokyoMetro::CommonModules::Dictionary::RailwayLine::StringInfo

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/railway_line/tokyo_metro_lines_in_system.yaml" ).each do | item |
    const_name_base = item.underscore.upcase
    const_set( eval( ":#{ const_name_base }_IN_SYSTEM" ) , item )
    const_set( eval( ":#{ const_name_base }_SAME_AS" ) , "odpt.Railway:TokyoMetro.#{ item }" )
    const_set( eval( ":#{ const_name_base }" ) , "odpt.Railway:TokyoMetro.#{ item }" )
  end

end