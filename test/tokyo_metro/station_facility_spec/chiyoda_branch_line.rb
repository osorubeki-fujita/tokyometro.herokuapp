def chiyoda_branch_line
  ayase = ::TokyoMetro::Api.station_facilities.find { | item | item.same_as == "odpt.StationFacility:TokyoMetro.Ayase" }
  kita_ayase = ::TokyoMetro::Api.station_facilities.find { | item | item.same_as == "odpt.StationFacility:TokyoMetro.KitaAyase" }

  [ ayase , kita_ayase ].each do | facility_info |
    facility_info.platform_infos.each do | platform_info |
      if platform_info.car_composition == 3

        describe TokyoMetro::Api::StationFacility::Info::Platform::Info , "after converting railway line name \"odpt.Railway:TokyoMetro.ChiyodaBranch\"" do
          it "(#{facility_info.same_as}) should on Chiyoda Branch Line." do
            expect( platform_info.railway_line ).to eq( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
            expect( platform_info.railway_line ).not_to eq( "odpt.Railway:TokyoMetro.Chiyoda" )
          end
        end

      end
    end
  end

  ayase.platform_infos.each do | platform_info |
    if platform_info.car_composition == 10
      if platform_info.transfer_infos.present?

        platform_info.transfer_infos.each do | transfer_info |
          if transfer_info.railway_direction == "odpt.RailDirection:TokyoMetro.KitaAyase"

            describe TokyoMetro::Api::StationFacility::Info::Platform::Info::Transfer::Info do
              it "(transfer info from Chiyoda Line in Ayase) should be connected to Chiyoda Branch Line." do
                expect( transfer_info.railway_line ).to eq( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
              end
            end

          end
        end

      end
    end
  end

end