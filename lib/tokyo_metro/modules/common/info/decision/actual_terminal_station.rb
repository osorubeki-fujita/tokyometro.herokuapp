module TokyoMetro::Modules::Common::Info::Decision::ActualTerminalStation

  # @!group 列車の行先に関するメソッド (1) - 駅

  def actually_bound_for?( *args , compared )
    compare_base( args , compared )
  end

  #-------- [alias]
  alias :is_actually_bound_for? :actually_bound_for?

  ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def actually_terminating_at_#{ const_name.downcase }?
        actually_terminating?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.#{ const_name.downcase } )
      end
    DEF

    #-------- [alias]
    [ :is_actually_terminating_at , :actually_terminate_at ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ const_name.downcase }? :actually_terminating_at_#{ const_name.downcase }?
      ALIAS
    end
  end

  ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def actually_terminating_at_#{ const_name.downcase }?
        actually_terminating?( ::TokyoMetro::Modules::Common::Dictionary::Station::RegexpInfo.#{ const_name.downcase } )
      end
    DEF

    #-------- [alias]
    [ :is_actually_terminating_at , :actually_terminate_at ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ const_name.downcase }? :actually_terminating_at_#{ const_name.downcase }?
      ALIAS
    end
  end

  # @!group 列車の行先に関するメソッド (2) - 路線

  ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.constants( false ).each do | const_name |
    eval <<-DEF
      def actually_terminating_on_#{ const_name.downcase }?
        actually_terminating?( ::TokyoMetro::Modules::Common::Dictionary::RailwayLine::RegexpInfo.#{ const_name.downcase } )
      end
    DEF

    #-------- [alias]
    [ :is_actually_terminating_on , :actually_terminate_on ].each do | prefix |
      eval <<-ALIAS
        alias :#{ prefix }_#{ const_name.downcase }? :actually_terminating_on_#{ const_name.downcase }?
      ALIAS
    end
  end

  # @!group 列車の行先に関するメソッド (3) - 区間

  def actually_terminating_on_marunouchi_branch_line_including_invalid?
    actually_terminating?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.between_honancho_and_nakano_sakaue_including_invalid )
  end

  #-------- [alias]
  [ :is_actually_terminating_on , :actually_terminate_on ].each do | prefix |
    eval <<-ALIAS
      alias :#{ prefix }_marunouchi_branch_line_including_invalid? :actually_terminating_on_marunouchi_branch_line_including_invalid?
    ALIAS
  end

  # @!endgroup

  private

  # @param args [Regexp or String] 比較に使用する正規表現または文字列
  # @param compared [String] 比較対象（include されるクラスで指定する）
  # @note include されるクラス・モジュールで、super を用いるなどして上書きする。
  def actually_terminating?( *args , compared )
    compare_base( args , compared )
  end

  alias :is_actually_terminating? :actually_terminating?
  alias :actually_terminate? :actually_terminating?

end