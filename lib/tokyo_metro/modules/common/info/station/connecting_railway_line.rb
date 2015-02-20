module TokyoMetro::Modules::Common::Info::Station::ConnectingRailwayLine

  def connected_to_another_station?
    connecting_to_another_station?
  end

  [ :connecting_to_another_station , :connected_to_another_station , :cleared ].each do | method_base_name |
    eval <<-DEF
      def not_#{method_base_name}?
        !( #{method_base_name}? )
      end
    DEF
  end

  def recommended?
    !( not_recommended? )
  end

  [ :connecting_to_another_station , :connected_to_another_station , :cleared , :recommended  ].each do | method_base_name |
    eval <<-DEF
      def is_#{ method_base_name }?
        #{ method_base_name }?
      end

      def is_not_#{ method_base_name }?
        not_#{ method_base_name }?
      end
    DEF
  end

end