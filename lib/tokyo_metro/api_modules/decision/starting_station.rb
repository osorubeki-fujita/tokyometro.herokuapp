module TokyoMetro::ApiModules::Decision::StartingStation

  include ::TokyoMetro::CommonModules::Decision::StartingStation

  private

  def is_starting?( regexp_or_string )
    super( regexp_or_string , @starting_station )
  end

end