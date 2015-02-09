class TokyoMetro::Factories::Seed::Api::StationFacility::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility
  include ::TokyoMetro::Factories::Seed::Reference::DcDate

  private

  def hash_to_db
    {
      id_urn: @info.id_urn ,
      same_as: @info.same_as ,
      dc_date: dc_date
    }
  end

end