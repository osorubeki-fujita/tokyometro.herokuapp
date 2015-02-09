def fundamental_infos_of_station_timetables
  ::TokyoMetro::Api.station_timetables.each do | station_timetable |

    describe ::TokyoMetro::Api::StationTimetable::Info do
      it "(#{station_timetable.same_as}) should contain fundamental infos." do
        expect( station_timetable.fundamental_infos ).to be_instance_of( ::TokyoMetro::Api::StationTimetable::Info::Fundamental::List )
      end
    end


    station_timetable.fundamental_infos.each do | fundamental_info |

      describe ::TokyoMetro::Api::StationTimetable::Info::Fundamental::List do
        it "(list of fundamental infos) should contain fundamental infos." do
          expect( fundamental_info ).to be_instance_of( ::TokyoMetro::Api::StationTimetable::Info::Fundamental::Info )
        end
      end

      [ :stations , :railway_lines , :operators , :railway_directions ].each do | method_name |
        iv = fundamental_info.send( method_name )

        describe ::TokyoMetro::Api::StationTimetable::Info::Fundamental::Info do
          it "should contain array infos as instance variables." do
            expect( iv ).to be_instance_of( ::Array )
          end
        end

        iv.each do | v |
          describe ::TokyoMetro::Api::StationTimetable::Info::Fundamental::Info do
            it "should contain array infos as instance variables of string." do
              expect(v).to be_instance_of( ::String )
            end
          end
        end

      end

    end

  end

end