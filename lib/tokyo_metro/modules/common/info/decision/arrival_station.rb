module TokyoMetro::Modules::Common::Info::Decision::ArrivalStation

  # @!group 到着駅に関するメソッド

  def arrival_at_yoyogi_uehara?
    arrival_at?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.yoyogi_uehara )
  end

  def arrival_at_wakoshi?
    arrival_at?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringList.wakoshi )
  end

  def arrival_at_wakoshi_on_yurakucho_line?
    arrival_at?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.wakoshi_on_yurakucho_line )
  end

  def arrival_at_wakoshi_on_fukutoshin_line?
    arrival_at?( ::TokyoMetro::Modules::Common::Dictionary::Station::StringInfo.wakoshi_on_fukutoshin_line )
  end

  #-------- [alias]
  [ :at_yoyogi_uehara , :at_wakoshi , :at_wakoshi_on_yurakucho_line , :at_wakoshi_on_fukutoshin_line ].each do | method_base_name |
    eval <<-ALIAS
      alias :is_arrival_#{ method_base_name }? :arrival_#{ method_base_name }?
      alias :arrive_#{ method_base_name }? :arrival_#{ method_base_name }?
    ALIAS
  end

  # @!endgroup

  private

  # @param args [::Array <::String or ::Regexp>]
  def arrival_at?( *args , compared )
    compared.present? and compare_base( args , compared )
  end

  alias :is_arrival_at? :arrival_at?
  alias :arrive_at? :arrival_at?

end