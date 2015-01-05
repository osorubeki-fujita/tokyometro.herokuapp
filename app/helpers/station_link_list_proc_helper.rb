module StationLinkListProcHelper

  private

  def station_link_proc_ja
    Proc.new { | station , tokyo_metro_station_dictionary |
      name_ja , name_hira , name_in_system , name_en , station_codes = station_link_set_variables( station )
      # raise "Error: The variable \"name_in_system\" of Station\##{station.id} is nil." if name_in_system.nil?
      name_ja = name_ja.process_specific_letter
      title = [ station_codes_in_title( station_codes ) , "#{ name_ja } - #{ name_hira } (#{ name_en }) " ].join( " " )
      link_to( name_ja , name_in_system.underscore , title: title )
    }
  end

  def station_link_proc_en
    Proc.new { | station , tokyo_metro_station_dictionary |
      name_ja , name_hira , name_in_system , name_en , station_codes = station_link_set_variables( station )
      name_ja = name_ja.process_specific_letter
      title = [ station_codes_in_title( station_codes ) , "#{ name_en } - #{ name_ja } （#{ name_hira }）" ].join( " " )
      link_to( name_en , name_in_system.underscore , title: title )
    }
  end

  def station_codes_in_title( station_codes )
    "\[ #{ station_codes.join(" , " ) } \]"
  end

  def station_link_set_variables( info )
    [ info[ :name_ja ] , info[ :name_hira ] , info[ :name_in_system ] , info[ :name_en ] , info[ :station_codes ] ]
  end

end