module TokyoMetro::CommonModules::Decision::TrainType

  # @!group 列車種別に関するメソッド

  ::YAML.load_file( "#{ ::TokyoMetro.dictionary_dir }/train_type_basename_in_api.yaml" ).each do | train_type_basename |
    method_base_name = train_type_basename.underscore.downcase
    train_type_in_api = "odpt.TrainType:TokyoMetro.#{ train_type_basename }"
    eval <<-DEF
      def is_#{ method_base_name }?
        is_train_type_of?( \"#{ train_type_in_api }\" )
      end
    DEF
  end

  [ :unknown , :extra ].each do | train_type |
    eval <<-DEF
      def is_#{ train_type.to_s }_train?
        is_train_type_of?( "odpt.TrainType:TokyoMetro.#{ train_type.to_s.capitalize }" )
      end
    DEF
  end

  def is_limited_express_or_romance_car?
    is_limited_express? or is_romance_car?
  end

  def method_missing( method_name )
    if /\A(?:is_)?(\w+)(?:_train)?\?\Z/ =~ method_name.to_s
      valid_method = "is_#{$1}?".intern
      if methods.include?( valid_method )
        return send( valid_method )
      end
    end

    if /\A(?:is_)?(limited_express(?:_train)?_or_romance_car(?:_train)?\?)\Z/ =~ method_name.to_s
      valid_method = ( "is_" + $1.gsub( /_train/ , "" ) ).intern
      if methods.include?( valid_method )
        return send( valid_method )
      end
    end

    super
  end

  private

  def is_train_type_of?( *variables , compared )
    raise if variables.empty?
    variables.include?( compared )
  end

end