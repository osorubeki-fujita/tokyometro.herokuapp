class TokyoMetro::Factory::Seed::Api::StationTimetable::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable
  include ::TokyoMetro::Factory::Seed::Api::StationTimetable::Common
  include ::TokyoMetro::Factory::Seed::Reference::DcDate

  def initialize( *args )
    super( *args , get_id: true )
  end

  private

  def hash_to_db
    {
      id_urn: @info.id_urn ,
      same_as: @info.same_as ,
      dc_date: dc_date
    }
  end

  def seed_optional_infos
    seed_fundamental_infos
  end

  def seed_fundamental_infos
    @info.fundamental_infos.seed( @id , @operators , @railway_lines , @stations , @railway_directions )
  end

end