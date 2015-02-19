module TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::AdditionalInfos::Generate::List

  def generate( max = nil )
    ary = super( max )

    ary = ary.delete_if { | item |
      ::TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::AdditionalInfos.ignored_station_timetables.include?( item.same_as )
    }

    ary.each do | item |
      replacing_infos_of_this_station_timetable = ::TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::AdditionalInfos.replacing_infos[ item.same_as ]
      if replacing_infos_of_this_station_timetable.present?

        replacing_name = replacing_infos_of_this_station_timetable[ "replacing_name" ]
        if replacing_name.present?
          item.instance_eval do
            @same_as = replacing_name
          end
        end

        replacing_fundamental_infos= replacing_infos_of_this_station_timetable[ "replacing_fundamental_infos" ]
        if replacing_fundamental_infos.present?
          new_ary_of_fundamental_infos = self.class.fundamental_list_class.new( replacing_fundamental_infos.map { | info |
            self.class.fundamental_info_class.new( info[ "stations"] , info[ "railway_lines" ] , info[ "operators" ] , info[ "railway_directions" ] )
          } )
          item.instance_eval do
            @fundamental_infos = new_ary_of_fundamental_infos
          end
        end

      end
    end

    return ary
  end

end