class TokyoMetro::Factory::Seed::Api::Fare::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::Fare
  include ::TokyoMetro::ClassNameLibrary::Static::Fare
  include ::TokyoMetro::Factory::Seed::Api::Fare::Common

  include ::TokyoMetro::Factory::Seed::Reference::FromAndToStation
  include ::TokyoMetro::Factory::Seed::Reference::Operator
  include ::TokyoMetro::Factory::Seed::Reference::NormalFareGroup
  include ::TokyoMetro::Factory::Seed::Reference::DcDate

  private

  def hash_to_db
    h = ::Hash.new

    [ :same_as , :id_urn ].each do | key_name |
      h[ key_name ] = @info.send( key_name )
    end

    [ :dc_date , :normal_fare_group_id , :operator_id , :from_station_id , :to_station_id ].each do | key_name |
      h[ key_name ] = self.send( key_name )
    end

    h
  end

  def normal_fare_group_id
    super( @normal_fares )
  end

  def operator_id
    super( @operators )
  end

end