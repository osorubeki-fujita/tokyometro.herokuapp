class TokyoMetro::Factory::Seed::Api::Station::List < TokyoMetro::Factory::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::Factory::Seed::Api::Station::Common

  private

  def set_array_to_seed( array )
    @array_to_seed = array.to_seed
  end

end