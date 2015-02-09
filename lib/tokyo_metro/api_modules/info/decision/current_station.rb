module TokyoMetro::ApiModules::Info::Decision::CurrentStation

  include ::TokyoMetro::CommonModules::Info::Decision::CurrentStation

  private

  def station_same_as__is_in?( *args , compared: @station )
    raise if args.empty?
    super( *args , compared )
  end

end