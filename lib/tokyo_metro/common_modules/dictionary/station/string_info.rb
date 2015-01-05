module TokyoMetro::CommonModules::Dictionary::Station::StringInfo

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  ::YAML.load_file( "#{ ::TokyoMetro::dictionary_dir }/station/frequently_appeared.yaml" ).each do | const_name , v |
    const_set( eval( ":#{ const_name.upcase }" ) , v )
  end
  
end