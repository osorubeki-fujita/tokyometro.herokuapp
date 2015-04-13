module TokyoMetro::Modules::Db::Decision::CurrentStation

  include ::TokyoMetro::Modules::Common::Info::Decision::CurrentStation

  def station_same_as__is_in?( *args )
    super( *args , same_as )
  end

end