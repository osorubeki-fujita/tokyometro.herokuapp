def station
  ::TokyoMetro::Static.stations.each do | railway_line_name , infos_of_a_railway_line |
    infos_of_a_railway_line.each do | station_name , station_info |

      describe ::TokyoMetro::Static::Station::InEachRailwayLine::Info do
        it "(station info of \'#{station_name}\') should contain a station facility info." do
          expect( station_info.station_facility ).to be_present
        end
      end

    end
  end
end