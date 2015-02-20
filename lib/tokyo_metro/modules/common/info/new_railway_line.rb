module TokyoMetro::Modules::Common::Info::NewRailwayLine

  def not_operated_yet?
    start_on.present? and ::Time.now < start_on
  end

  def operated_already?
    !( not_operated_yet? )
  end

  def already_operated?
    operated_already?
  end

  [ :not_operated_yet? , :operated_already? , :already_operated? ].each do | method_base_name |
    eval <<-ALIAS
      def is_#{ method_base_name }
        #{ method_base_name }
      end
    ALIAS
  end

end