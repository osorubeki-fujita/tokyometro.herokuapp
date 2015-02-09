class TokyoMetro::Factories::Seed::Api::Station::List::Common < TokyoMetro::Factories::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::Station

  private

  def set_array_to_seed( array )
    @array_to_seed = array.to_seed
  end

  def optional_variables
    [ @indent + 1 ]
  end

end