def additional_infos_of_station_timetables

  ::TokyoMetro::ApiModules::Convert::Customize::StationTimetable::AdditionalInfos.ignored_station_timetables.each do | station_timetable_name |
    station_timetable_instance = ::TokyoMetro::Api.station_timetables.find { | item | item.same_as == station_timetable_name }
    describe ::TokyoMetro::Api::StationTimetable::Info , "after deleting specific infos" do
      it "(#{station_timetable_name}) should not be present." do
        expect( station_timetable_instance ).not_to be_present
      end
    end
  end

  ::TokyoMetro::ApiModules::Convert::Customize::StationTimetable::AdditionalInfos.replacing_infos.each do | station_timetable_name_before_conversion , additional_infos |
    replacing_name = additional_infos[ "replacing_name" ]
    if replacing_name.present?
      station_timetable_name_after_conversion = replacing_name
    else
      station_timetable_name_after_conversion = station_timetable_name_before_conversion
    end

    if replacing_name.present?
      station_timetable_instance_before_conversion = ::TokyoMetro::Api.station_timetables.find { | item | item.same_as == station_timetable_name_before_conversion }
      describe ::TokyoMetro::Api::StationTimetable::Info , "after replacing station timetable name" do
        it "(#{station_timetable_name_before_conversion}) should not be present." do
          expect( station_timetable_instance_before_conversion ).not_to be_present
        end
      end
    end

    station_timetable_instance_after_conversion = ::TokyoMetro::Api.station_timetables.find { | item | item.same_as == station_timetable_name_after_conversion }

    describe ::TokyoMetro::Api::StationTimetable::Info , "after replacing station timetable name" do
      it "(#{station_timetable_name_after_conversion}) should be present." do
        expect( station_timetable_instance_after_conversion ).to be_present
        expect( station_timetable_instance_after_conversion ).to be_instance_of( ::TokyoMetro::Api::StationTimetable::Info )
      end
    end

    fundamental_infos_after_conversion = station_timetable_instance_after_conversion.fundamental_infos

    replacing_fundamental_infos = additional_infos[ "replacing_fundamental_infos" ]

    describe ::TokyoMetro::Api::StationTimetable::Info , "after replacing station timetable fundamental infos" do
      it "(#{station_timetable_instance_after_conversion.same_as}) should be of the same size as replacing fundamental infos." do
        expect( replacing_fundamental_infos.length ).to eq( fundamental_infos_after_conversion.length )
      end
    end

    replacing_fundamental_infos.each do | replacing_fundamental_info |

      info_in_api = fundamental_infos_after_conversion.find { | in_api |
        [ :stations , :railway_lines , :operators , :railway_directions ].all? { | method |
          in_api.send( method ).sort == replacing_fundamental_info[ method.to_s ].sort
        }
      }

      describe ::TokyoMetro::Api::StationTimetable::Info , "after replacing station timetable fundamental infos" do
        it "(#{station_timetable_instance_after_conversion.same_as}) should be replaced." do
          expect( info_in_api ).to be_present
        end
      end

    end

  end

end