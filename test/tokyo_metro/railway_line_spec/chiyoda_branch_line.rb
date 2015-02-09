def chiyoda_branch_line
  chiyoda_line = ::TokyoMetro::Api.railway_lines.find { | item | /Chiyoda\Z/ === item.same_as }
  chiyoda_branch_line = ::TokyoMetro::Api.railway_lines.find { | item | /ChiyodaBranch\Z/ === item.same_as }

  chiyoda_line_station_order_kita_ayase = chiyoda_line.station_order.find { | item | /KitaAyase/ === item.station }
  chiyoda_line_travel_time_between_ayase_and_kita_ayase = chiyoda_line.travel_time.select { | item |
    item.between?( "odpt.Station:TokyoMetro.Chiyoda.Ayase" , "odpt.Station:TokyoMetro.Chiyoda.KitaAyase" )
  }

  describe ::TokyoMetro::Api::RailwayLine::List , "after add Chiyoda Branch Line" do

    describe "千代田線（本線 / 代々木上原 - 綾瀬）" do

      describe "station_order" do
        # 北綾瀬は含まれない
        it "(the station order info of Kita-ayase) should be nil." do
          expect( chiyoda_line_station_order_kita_ayase ).to be_nil
        end
      end

      describe "travel_time" do
        #綾瀬・北綾瀬間の情報は含まれない
        it "(the travel time info between Ayase and Kita-ayase) should be empty." do
          expect( chiyoda_line_travel_time_between_ayase_and_kita_ayase ).to be_empty
        end
      end

    end

    describe "千代田線（支線 / 綾瀬 - 北綾瀬）" do

      describe "same_as" do
        # "odpt.Railway:TokyoMetro.ChiyodaBranch"
        it "the information of Chiyoda Branch Line) should be same as \"odpt.Railway:TokyoMetro.ChiyodaBranch\"." do
          expect( chiyoda_branch_line.same_as ).to eq( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
        end
      end

      describe "station_order" do
        # station_order の長さは 2
        it "(the length of station order array of Chiyoda Branch Line) should be 2." do
          expect( chiyoda_branch_line.station_order.length ).to eq(2)
        end

        # 最初の要素は "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase" (index: 0)
        it "(the first element of station order info of Chiyoda Branch Line) should be \#0 Ayase." do
          expect( chiyoda_branch_line.station_order[0].station ).to eq( "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase" )
          expect( chiyoda_branch_line.station_order[0].index ).to eq(0)
        end

        # 次の要素は "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" (index: 1)
        it "(the second element of station order info of Chiyoda Branch Line) should be \#1 Kita-ayase." do
          expect( chiyoda_branch_line.station_order[1].station ).to eq( "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" )
          expect( chiyoda_branch_line.station_order[1].index ).to eq(1)
        end
      end

      describe "travel_time" do
        it "(the length of travel time array of Chiyoda Branch Line) should be 2." do
          expect( chiyoda_branch_line.travel_time.length ).to eq( ( chiyoda_branch_line.station_order.length - 1 ) * 2 )
        end
      end

    end

  end

end