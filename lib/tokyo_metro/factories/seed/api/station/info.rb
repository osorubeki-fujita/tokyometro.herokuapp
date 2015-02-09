class TokyoMetro::Factories::Seed::Api::Station::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::Station
  include ::TokyoMetro::Factories::Seed::Api::Station::Common

  include ::TokyoMetro::Factories::Seed::Reference::Operator
  include ::TokyoMetro::Factories::Seed::Reference::RailwayLine
  include ::TokyoMetro::Factories::Seed::Reference::StationFacility
  include ::TokyoMetro::Factories::Seed::Reference::DcDate

  private

  def hash_to_db
    h = ::Hash.new

    [ :id_urn , :same_as , :name_ja , :station_code , :longitude , :latitude , :geo_json ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    [ :dc_date , :operator_id , :railway_line_id , :station_facility_id ].each do | key_name |
      h[ key_name ] = self.send( key_name )
    end

    h
  end

  def operator_id
    super( @operators )
  end

  def railway_line_id
    super( @railway_lines )
  end

  def station_facility_id
    super( @station_facilities )
  end

end