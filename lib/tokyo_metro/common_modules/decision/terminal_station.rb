module TokyoMetro::CommonModules::Decision::TerminalStation

  # @!group 列車の行先に関するメソッド (1) - 駅

  def bound_for?( list_of_train_terminal_station , compared )
    list_of_train_terminal_station.any? { | item | item == compared }
  end

  ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def is_terminating_at_#{ const_name.to_s.downcase }?
        is_terminating?( ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.#{ const_name.to_s.downcase } )
      end
    DEF
  end

  ::TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def is_terminating_at_#{ const_name.to_s.downcase }?
        is_terminating?( ::TokyoMetro::CommonModules::Dictionary::Station::RegexpInfo.#{ const_name.to_s.downcase } )
      end
    DEF
  end

  # @!group 列車の行先に関するメソッド (2) - 路線

  ::TokyoMetro::CommonModules::Dictionary::RailwayLine::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def is_terminating_on_#{ const_name.to_s.downcase }?
        is_terminating?( ::TokyoMetro::CommonModules::Dictionary::RailwayLine::RegexpInfo.#{ const_name.to_s.downcase } )
      end
    DEF
  end

  def method_missing( method_name )
    if /\Aterminat(?:e|ing)_((?:at|on)_\w+\?)\Z/ =~ method_name.to_s
      valid_method = "is_terminating_#{$1}".intern
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
  # @note include されるクラス・モジュールで、super を用いるなどして上書きする。（include されるクラスにより、compared の部分が @terminal_station になったり @terminal_station_instance.same_as になったりするため）
  def is_terminating?( regexp_or_string , compared )
    regexp_or_string === compared
  end

end