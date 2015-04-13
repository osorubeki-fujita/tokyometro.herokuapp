module TokyoMetro::Refinement::Api::StationTimetable::Info::Fundamental::Info

  refine TokyoMetro::Api::StationTimetable::Info::Fundamental::Info do

    def convert_railway_line!( regexp , str )
      @railway_lines.each do | railway_line |
        railway_line.gsub!( regexp , str )
      end
    end

    def convert_station!( regexp , str )
      @stations.each do | station |
        station.gsub!( regexp , str )
      end
    end

  end

end