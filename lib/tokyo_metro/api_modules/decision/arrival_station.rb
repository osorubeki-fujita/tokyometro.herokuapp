module TokyoMetro::ApiModules::Decision::ArrivalStation

  include ::TokyoMetro::CommonModules::Decision::ArrivalStation

  private

  def is_arrival_at?( *list_of_regexp_or_string , arrival_station_info )
    super( *list_of_regexp_or_string , @arrival_station )
  end

end