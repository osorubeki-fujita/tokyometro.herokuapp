class TokyoMetro::Factory::Generate::Static::TrainType::Custom::Main::Info < TokyoMetro::Factory::Generate::Static::TrainType::Custom::DefaultSetting::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::Main
  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  TITLE = "TrainTypeMain"

  def self.referenced_hash
    ::TokyoMetro::Static.train_types_other_operator.merge( ::TokyoMetro::Static.train_types_default )
  end

  def self.hash_keys
    super + hash_keys_3
  end

  def self.hash_keys_3
    [ :note , :css_class_name_in_document ]
  end

  private

  def set_values_to_hash_for_making_variables_when_reference_is_used
    set_values_to_hash_for_making_variables_from_referenced_info( hash_key_array: self.class.hash_keys_1 )
    # puts "1: " + @hash_for_making_variables.to_s
    set_values_to_hash_for_making_variables__alias( hash_key_array: self.class.hash_keys_2 )
    # puts "2: " + @hash_for_making_variables.to_s
    set_values_to_hash_for_making_variables__alias( hash_key_array: self.class.hash_keys_3 )
    # puts "3: " + @hash_for_making_variables.to_s
  end

  def set_values_to_hash_for_making_variables_when_reference_is_not_used
    super
    set_values_to_hash_for_making_variables__alias( hash_key_array: self.class.hash_keys_3 )
  end

  def variables_from_hash_keys
    variables_from_hash_keys__alias( hash_key_array: self.class.hash_keys )
  end

  def decinding_keys_in_variables_from_hash
    @h.keys - ( self.class.hash_keys_2 + self.class.hash_keys_3 + [ :stopping_pattern , :note_sub ] ).map( &:to_s )
  end

  def check_varidity_of_referenced_info( info )
    super( info , include_ancestors: true )
  end

end