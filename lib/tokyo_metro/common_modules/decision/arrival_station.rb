module TokyoMetro::CommonModules::Decision::ArrivalStation

  # @!group 到着駅に関するメソッド

  def is_arrival_at_yoyogi_uehara?
    is_arrival_at?( ::TokyoMetro::CommonModules::Dictionary::Station::StringList.yoyogi_uehara )
  end

  def is_arrival_at_wakoshi?
    is_arrival_at?( ::TokyoMetro::CommonModules::Dictionary::Station::StringList.wakoshi )
  end

  def is_arrival_at_wakoshi_on_yurakucho_line?
    is_arrival_at?( ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.wakoshi_on_yurakucho_line )
  end

  def is_arrival_at_wakoshi_on_fukutoshin_line?
    is_arrival_at?( ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.wakoshi_on_fukutoshin_line )
  end

  def method_missing( method_name )
    if /\Aarriv(?:al|e)_(at_\w+\?)\Z/ =~ method_name.to_s
      valid_method = "is_arrival_#{$1}".intern
      if methods.include?( valid_method )
        return send( valid_method )
      end
    end
    super
  end

  # @!endgroup

  private

  # @param variables [::Array <::String or ::Regexp>]
  def is_arrival_at?( *variables , arrival_station_info )
    raise if variables.empty?
    arrival_station_info.present? and variables.flatten.any? { | item | item === arrival_station_info }
  end

end