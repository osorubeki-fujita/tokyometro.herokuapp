def replacing_railway_lines
  list_of_replacing_railway_lines = ::TokyoMetro::ApiModules::Convert::Customize::StationFacility::RailwayLineNameInPlatformTransferInfo.replacing_railway_lines

  ::TokyoMetro::Api.station_facilities.each do | station_facility |
    # この駅に関係する情報のみを取得
    replacing_railway_line_infos_of_this_station = list_of_replacing_railway_lines.select { | railway_line , infos |
      infos[ "stations" ].include?( station_facility.same_as )
    }

    if replacing_railway_line_infos_of_this_station.present?
      station_facility.platform_infos.each do | platform_info |
        if platform_info.transfer_infos.present?

          platform_info.transfer_infos.each do | transfer_info |
            replacing_railway_line_infos_of_this_station.keys.each do | invalid_railway_line_name |

              describe ::TokyoMetro::Api::StationFacility::Info::Platform::Info::Transfer::Info , "after converting railway line name" do
                it "should not be \"#{invalid_railway_line_name}\"." do
                  expect( transfer_info.railway_line ).not_to eq( invalid_railway_line_name )
                end
              end

            end
          end

        end
      end
    end

  end
end