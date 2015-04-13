class TokyoMetro::Factory::Generate::Static::TrainType::Custom::DefaultSetting::Info < TokyoMetro::Factory::Generate::Static::TrainType::Custom::OtherOperator::Info

  include ::TokyoMetro::ClassNameLibrary::Static::TrainType::Custom::DefaultSetting
  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  TITLE = "TrainTypeDefault"

  # @note {TokyoMetro::Factory::Generate::Static::TrainType::Custom::Main::Info} で上書き
  def self.referenced_hash
    ::TokyoMetro::Static.train_types_other_operator
  end

  private

  alias :set_values_to_hash_for_making_variables_when_reference_is_not_used :set_values_to_hash_for_making_variables

  def set_values_to_hash_for_making_variables
    if use_reference?
      # puts "Use reference"
      set_values_to_hash_for_making_variables_when_reference_is_used
    else
      # puts "Not use referece"
      set_values_to_hash_for_making_variables_when_reference_is_not_used
    end
  end

  def set_values_to_hash_for_making_variables_when_reference_is_used
    set_values_to_hash_for_making_variables_from_referenced_info
  end

  def set_values_to_hash_for_making_variables_from_referenced_info( hash_key_array: self.class.hash_keys )
    hash_key_array.each do | key_name |
      @hash_for_making_variables[ key_name ] = referenced_info.send( key_name )
    end
  end

  def use_reference?
    decinding_keys_in_variables_from_hash == [ "ref" ]
  end

  def decinding_keys_in_variables_from_hash
    @h.keys
  end

  # 参照のためのキー
  def key_for_reference
    @h[ "ref" ]
  end

  def referenced_info
    # ハッシュから取得する値
    info = self.class.referenced_hash[ key_for_reference ]
    check_varidity_of_referenced_info( info )
    info
  end

  def check_varidity_of_referenced_info( info , include_ancestors: false )
    class_name = ::TokyoMetro::Static::TrainType::Custom::OtherOperator::Info

    unless ( include_ancestors and info.kind_of?( class_name ) ) or info.instance_of?( class_name )
      str = "\n" + "Error: The variable \#1 \"referenced_info\" is not valid. ("
      if key_for_reference.present?
        str << "Key for reference: #{ key_for_reference }, "
      end
      str << "Class: #{info.class.name})"
      str << "\n"
      str << "The variable should be an instance "
      if include_ancestors
        str << "or inheritance "
      end
      str << "of \"#{class_name}\"."
      raise str
    end

    if info.nil?
      raise "Error: The variable \#1 \"referenced_info\" should not be nil."
    end
  end

end