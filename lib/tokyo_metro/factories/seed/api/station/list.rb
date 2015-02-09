class TokyoMetro::Factories::Seed::Api::Station::List < TokyoMetro::Factories::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::Factories::Seed::Api::Station::Common

  private

  def set_array_to_seed( array )
    @array_to_seed = array.to_seed
  end

end