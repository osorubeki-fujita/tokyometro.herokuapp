class TokyoMetro::Factory::Seed::Api::StationFacility::List::Common < TokyoMetro::Factory::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  private

  def optional_variables
    [ @indent + 1 ]
  end

end