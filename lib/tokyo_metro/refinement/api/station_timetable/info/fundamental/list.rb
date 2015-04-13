module TokyoMetro::Refinement::Api::StationTimetable::Info::Fundamental::List

  using TokyoMetro::Refinement::Api::StationTimetable::Info::Fundamental::Info

  # refine TokyoMetro::Api::StationTimetable::Info::Fundamental::List do

    def convert_railway_lines!( regexp , str )
      self.each do | item |
        item.convert_railway_line!( regexp , str )
      end

      return self
    end

    def convert_stations!( regexp , str )
      self.each do | item |
        item.convert_station!( regexp , str )
      end

      return self
    end

  # end

end