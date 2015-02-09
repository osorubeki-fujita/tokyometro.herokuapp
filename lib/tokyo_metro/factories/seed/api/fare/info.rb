class TokyoMetro::Factories::Seed::Api::Fare::Info < TokyoMetro::Factories::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::Fare
  include ::TokyoMetro::ClassNameLibrary::Static::Fare
  include ::TokyoMetro::Factories::Seed::Api::Fare::Common

  include ::TokyoMetro::Factories::Seed::Reference::FromAndToStation
  include ::TokyoMetro::Factories::Seed::Reference::Operator
  include ::TokyoMetro::Factories::Seed::Reference::NormalFareGroup
  include ::TokyoMetro::Factories::Seed::Reference::DcDate

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