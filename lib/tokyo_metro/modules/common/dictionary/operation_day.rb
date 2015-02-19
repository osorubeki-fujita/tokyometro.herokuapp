module TokyoMetro::Modules::Common::Dictionary::OperationDay

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  ::YAML.load_file( "#{ ::TokyoMetro.dictionary_dir }/operation_day.yaml" ).each do | item |
    const_name = item[ "name_en" ].gsub( /\,? / , "_" ).upcase.intern
    const_set( const_name , item.with_indifferent_access )
  end

  def self.constants_except_for_class_methods
    ( self.constants - [ :ClassMethods ] )
  end

  def self.list
    constants_except_for_class_methods.map { | const_name |
      h = const_get( const_name )
      [ h[ :name_ja ] , h[ :name_en ] ]
    }
  end

  def self.hash_list
    h = ::Hash.new
    constants_except_for_class_methods.each do | const_name |
      h_const = const_get( const_name )
      h[ h_const[ :name_en ] ] = h_const
    end
    h
  end

end