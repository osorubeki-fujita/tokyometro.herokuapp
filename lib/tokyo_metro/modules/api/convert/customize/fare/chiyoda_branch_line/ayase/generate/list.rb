module TokyoMetro::Modules::Api::Convert::Customize::Fare::ChiyodaBranchLine::Ayase::Generate::List

  REGEXP_OF_CHIYODA_BRANCH = /Chiyoda(?=\.Ayase(?:\.|\Z))/

  def generate( max = nil )
    ary = super( max )

    fares_from_ayase = ary.select { | item | item.from_station == "odpt.Station:TokyoMetro.Chiyoda.Ayase" }
    fares_to_ayase = ary.select { | item | item.to_station == "odpt.Station:TokyoMetro.Chiyoda.Ayase" }

    fares_from_ayase.each do | item |
      ary << fare_info_from_ayase_chiyoda_branch( item )
    end

    fares_to_ayase.each do | item |
      ary << fare_info_to_ayase_chiyoda_branch( item )
    end

    return ary
  end

  private

  def fare_info_from_ayase_chiyoda_branch( item )
    fare_info_from_or_to_ayase_chiyoda_branch( item , :from_station )
  end

  def fare_info_to_ayase_chiyoda_branch( item )
    fare_info_from_or_to_ayase_chiyoda_branch( item , :to_station )
  end

  def fare_info_from_or_to_ayase_chiyoda_branch( item , condition )
    h = hash_for_variables_of_fare_info_from_or_to_ayase_chiyoda_branch( item , condition )

    variables = fare_info_variable_names.map { | variable_name | h[ variable_name ] }
    ::TokyoMetro::Api::Fare::Info.new( *variables )
  end

  def fare_info_variable_names
    [ :id_urn , :same_as , :dc_date , :operator , :from_station , :to_station , :normal_fare ]
  end

  def hash_for_variables_of_fare_info_from_or_to_ayase_chiyoda_branch( item , condition )
    h = ::Hash.new

    h[ :same_as ] = item.same_as.gsub( REGEXP_OF_CHIYODA_BRANCH , "ChiyodaBranch" )

    [ :id_urn , :dc_date , :operator , :normal_fare , :from_station , :to_station ].each do | method_name |
      h[ method_name ] = item.send( method_name )
    end

    case condition
    when :from_station
      h[ :from_station ] = h[ :from_station ].gsub( REGEXP_OF_CHIYODA_BRANCH , "ChiyodaBranch" )
    when :to_station
      h[ :to_station ] = h[ :to_station ].gsub( REGEXP_OF_CHIYODA_BRANCH , "ChiyodaBranch" )
    end

    h
  end

end