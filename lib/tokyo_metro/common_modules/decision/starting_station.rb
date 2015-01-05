module TokyoMetro::CommonModules::Decision::StartingStation

  # @!group 列車の始発駅に関するメソッド (1) - 駅

  ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def is_starting_at_#{ const_name.to_s.downcase }?
        is_starting?( ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.#{ const_name.to_s.downcase } )
      end
    DEF
  end

  ::TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def is_starting_at_#{ const_name.to_s.downcase }?
        is_starting?( ::TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo.#{ const_name.to_s.downcase } )
      end
    DEF
  end

  # @!group 列車の始発駅に関するメソッド (2) - 路線

  ::TokyoMetro::CommonModules::Dictionary::RailwayLine::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def is_starting_on_#{ const_name.to_s.downcase }?
        is_starting?( ::TokyoMetro::CommonModules::Dictionary::RailwayLine::RegexpInfo.#{ const_name.to_s.downcase } )
      end
    DEF
  end

  def method_missing( method_name )
    if /\Astart(?:ing)?_((?:at|on)_\w+\?)\Z/ =~ method_name.to_s
      valid_method = "is_starting_#{$1}".intern
      if methods.include?( valid_method )
        return send( valid_method )
      end
    end
    super
  end

  # @!endgroup

  private

  # @param regexp_or_string [Regexp or String] 比較に使用する正規表現または文字列
  # @param compared [String] 比較対象（include されるクラスで指定する）
  # @note include されるクラス・モジュールで、super を用いるなどして上書きする。（include されるクラスにより、compared の部分が @starting_station になったり @starting_station_instance.same_as になったりするため）
  def is_starting?( regexp_or_string , compared )
    regexp_or_string === compared
  end

end