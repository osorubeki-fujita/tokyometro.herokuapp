module TokyoMetro::Modules::Common::Info::Decision::TerminalStation

  # @!group 列車の行先に関するメソッド (1) - 駅

  # 列車の行先を判定するメソッド
  # @param args [Regexp or String] 比較に使用する正規表現または文字列
  # @param compared [String] 比較対象（include されるクラスで指定する）
  # @note include されるクラス・モジュールで、super を用いるなどして上書きする。（include されるクラスにより、compared の部分が @terminal_station になったり @terminal_station_in_db.same_as になったりするため）
  # @return [Boolean]
  # @note args を複数指定した場合は、指定された【いずれか】の駅を行先とする列車を取得する。
  def bound_for?( *args , compared )
    compare_base( args , compared )
  end

  #-------- [alias]
  alias :is_bound_for? :bound_for?
  alias :is_terminating? :bound_for?
  alias :terminate? :bound_for?

  #---------------- is_terminating_at_xxx?
  # @note ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo を用いて定義

  ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def terminating_at_#{ const_name.downcase }?
        bound_for?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.#{ const_name.downcase } )
      end
    DEF

    #-------- [alias]
    [ :is_terminating_at , :terminate_at ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ const_name.downcase }? :terminating_at_#{ const_name.downcase }?
      ALIAS
    end
  end

  #---------------- is_terminating_at_xxx?
  # @note ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo を用いて定義

  ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def terminating_at_#{ const_name.downcase }?
        bound_for?( ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.#{ const_name.downcase } )
      end
    DEF

    #-------- [alias]
    [ :is_terminating_at , :terminate_at ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ const_name.downcase }? :terminating_at_#{ const_name.downcase }?
      ALIAS
    end
  end

  # @!group 列車の行先に関するメソッド (2) - 路線

  #---------------- is_terminating_at_xxx?
  # @note ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo を用いて定義

  ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def terminating_on_#{ const_name.downcase }?
        bound_for?( ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.#{ const_name.downcase } )
      end
    DEF

    #-------- [alias]
    [ :is_terminating_on , :terminate_on ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ const_name.downcase }? :terminating_on_#{ const_name.downcase }?
      ALIAS
    end
  end

  # @!group 列車の行先に関するメソッド (3) - 区間

  def terminating_on_marunouchi_branch_line_including_invalid?
    bound_for?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_sakaue_including_invalid )
  end

  #-------- [alias]
  [ :is_terminating_on , :terminate_on ].each do | prefix |
    eval <<-ALIAS
      alias :#{ prefix }_marunouchi_branch_line_including_invalid? :terminating_on_marunouchi_branch_line_including_invalid?
    ALIAS
  end

  # @!endgroup

end