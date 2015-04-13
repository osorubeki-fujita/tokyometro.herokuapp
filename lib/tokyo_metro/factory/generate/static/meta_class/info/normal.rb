class TokyoMetro::Factory::Generate::Static::MetaClass::Info::Normal < TokyoMetro::Factory::Generate::Static::MetaClass::Info::Fundamental

  def initialize( same_as , h )
    @same_as = same_as
    @h = h.with_indifferent_access
    @hash_for_making_variables = ::Hash.new.with_indifferent_access

    # puts "same_as: #{ same_as }"
    # puts "hash keys: #{ @h.keys }"

    set_values_to_hash_for_making_variables
  end

  def variables
    # puts "variables: " + ( [ @same_as ] + variables_from_hash_keys ).to_s
    # puts "length: " + ( [ @same_as ] + variables_from_hash_keys ).length.to_s
    # puts ""
    [ @same_as ] + super
  end

  def variables_from_hash_keys( hash_key_array: self.class.hash_keys , info: @hash_for_making_variables )
    if info.nil?
      super( hash_key_array: hash_key_array )
    elsif info.kind_of?( ::Hash )
      hash_key_array.map { | key_name | info[ key_name ] }
    else
      hash_key_array.map { | key_name | info.send( key_name ) }
    end
  end

  alias :variables_from_hash_keys__alias :variables_from_hash_keys

end