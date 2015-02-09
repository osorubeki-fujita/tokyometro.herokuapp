module TokyoMetro::ApiModules::Info::Decision::StartingStation

  include ::TokyoMetro::CommonModules::Info::Decision::StartingStation

  private

  def starting?( *args , compared: @starting_station )
    super( *args , compared )
  end

  alias :is_starting? :starting?
  alias :start? :starting?

end