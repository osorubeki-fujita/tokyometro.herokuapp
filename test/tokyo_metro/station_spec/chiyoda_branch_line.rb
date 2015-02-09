def chiyoda_branch_line
  ayase = ::TokyoMetro::Api.stations.find { | item | /Chiyoda\.Ayase\Z/ === item.same_as }
  kita_ayase = ::TokyoMetro::Api.stations.find { | item | /Chiyoda\.KitaAyase\Z/ === item.same_as }
  ayase_branch = ::TokyoMetro::Api.stations.find { | item | /ChiyodaBranch\.Ayase\Z/ === item.same_as }
  kita_ayase_branch = ::TokyoMetro::Api.stations.find { | item | /ChiyodaBranch\.KitaAyase\Z/ === item.same_as }

  describe ::TokyoMetro::Api::Station::List , "after add Chiyoda Branch Line" do

    describe "千代田線（本線 / 代々木上原 - 綾瀬）" do

      describe "綾瀬" do
        describe "exist" do
          it "(the station info of Ayase on Chiyoda Line) should be present." do
            expect( ayase ).to be_present
          end
        end

        describe "same_as" do
          it "(the station info of Ayase on Chiyoda Line) should be same as \"odpt.Station:TokyoMetro.Chiyoda.Ayase\"." do
            expect( ayase.same_as ).to eq( "odpt.Station:TokyoMetro.Chiyoda.Ayase" )
          end
        end

        describe "connecting_railway_lines" do
          it "(the station info of Ayase on Chiyoda Line) should include connecting railway info of Chiyoda Branch Line." do
            expect( ayase.connecting_railway_lines.railway_lines ).to include( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
          end
        end
      end

      describe "北綾瀬" do
        describe "exist" do
          it "(the station info of Kita-ayase on Chiyoda Line) should not be present" do
            expect( kita_ayase ).to be_nil
          end
        end
      end

    end


    describe "千代田線（支線 / 綾瀬 - 北綾瀬）" do

      describe "綾瀬" do
        describe "exist" do
          it "(the station info of Ayase on Chiyoda Branch Line) should be present." do
            expect( ayase_branch ).to be_present
          end
        end

        describe "same_as" do
          it "(the station info of Ayase on Chiyoda Branch Line) should be same as \"odpt.Station:TokyoMetro.ChiyodaBranch.Ayase\"." do
            expect( ayase_branch.same_as ).to eq( "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase" )
          end
        end

        describe "railway_line" do
          it "(the station info of Ayase on Chiyoda Branch Line) should be on \"odpt.Railway:TokyoMetro.ChiyodaBranch\"." do
            expect( ayase_branch.railway_line ).to eq( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
          end
        end

        describe "connecting_railway_lines" do
          it "(the station info of Ayase on Chiyoda Branch Line) should include connecting railway info of Chiyoda Line." do
            expect( ayase_branch.connecting_railway_lines.railway_lines ).to include( "odpt.Railway:TokyoMetro.Chiyoda" )
          end
        end

        describe "id_urn" do
          it "(the station info of Ayase on Chiyoda Branch Line) should not contain \'id_urn\' info." do
            expect( ayase_branch.id_urn ).to be_nil
          end
        end

        describe "id_urn" do
          it "(the station info of Ayase on Chiyoda Branch Line) should not contain \'dc_date\' info." do
            expect( ayase_branch.dc_date ).to be_nil
          end
        end

      end

      describe "北綾瀬" do
        describe "exist" do
          it "(the station info of Kita-ayase on Chiyoda Branch Line) should be present." do
            expect( kita_ayase_branch ).to be_present
          end
        end

        describe "same_as" do
          it "(the station info of Kita-ayase on Chiyoda Branch Line) should be same as \"odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase\"." do
            expect( kita_ayase_branch.same_as ).to eq( "odpt.Station:TokyoMetro.ChiyodaBranch.KitaAyase" )
          end
        end

        describe "railway_line" do
          it "(the station info of Kita-ayase on Chiyoda Branch Line) should be on \"odpt.Railway:TokyoMetro.ChiyodaBranch\"." do
            expect( ayase_branch.railway_line ).to eq( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
          end
        end
      end

    end

  end
end