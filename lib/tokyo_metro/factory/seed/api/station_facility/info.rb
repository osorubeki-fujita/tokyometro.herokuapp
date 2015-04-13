class TokyoMetro::Factory::Seed::Api::StationFacility::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Factory::Seed::Reference::DcDate

  private

  def hash_to_db
    {
      id_urn: @info.id_urn ,
      same_as: @info.same_as ,
      dc_date: dc_date
    }
  end

end