def marunouchi_branch_line
  describe ::TokyoMetro::Api::Station::List , "of Marunouchi Branch Line" do

    nakano_sakaue_main = ::TokyoMetro::Api.stations.find { | item | /Marunouchi\.NakanoSakaue\Z/ === item.same_as }
    nakano_shimbashi_main = ::TokyoMetro::Api.stations.find { | item | /Marunouchi\.NakanoShimbashi\Z/ === item.same_as }
    nakano_fujimicho_main = ::TokyoMetro::Api.stations.find { | item | /Marunouchi\.NakanoFujimicho\Z/ === item.same_as }
    honancho_main = ::TokyoMetro::Api.stations.find { | item | /Marunouchi\.Honancho\Z/ === item.same_as }

    nakano_sakaue_branch = ::TokyoMetro::Api.stations.find { | item | /MarunouchiBranch\.NakanoSakaue\Z/ === item.same_as }
    nakano_shimbashi_branch = ::TokyoMetro::Api.stations.find { | item | /MarunouchiBranch\.NakanoShimbashi\Z/ === item.same_as }
    nakano_fujimicho_branch = ::TokyoMetro::Api.stations.find { | item | /MarunouchiBranch\.NakanoFujimicho\Z/ === item.same_as }
    honancho_branch = ::TokyoMetro::Api.stations.find { | item | /MarunouchiBranch\.Honancho\Z/ === item.same_as }

    invalid_stations_on_main = [
      [ "Honancho" , honancho_main ] ,
      [ "Nakano-fujimicho" , nakano_fujimicho_main ] ,
      [ "Nakano-shimbashi" , nakano_shimbashi_main ]
    ]

    stations_on_branch = [
      [ "Honancho" , honancho_branch ] ,
      [ "Nakano-fujimicho" , nakano_fujimicho_branch ] ,
      [ "Nakano-shimbashi" , nakano_shimbashi_branch ] ,
      [ "Nakano-sakaue" , nakano_sakaue_branch ]
    ]

    describe "丸ノ内線（本線 / 荻窪 - 池袋）" do

      describe "中野坂上" do

        describe "exist" do
          it "(the station info of Nakano-sakaue on Marunouchi Line) should be present." do
            expect( nakano_sakaue_main ).to be_present
          end
        end

        describe "railway_line" do
          it "(the station info of Nakano-sakaue on Marunouchi Line) should on Marunouchi Line." do
            expect( nakano_sakaue_main.railway_line ).to eq( "odpt.Railway:TokyoMetro.Marunouchi" )
          end
        end

        describe "connecting_railway_lines" do
          # odpt.Railway:TokyoMetro.MarunouchiBranch は含まれない
          it "(the station info of Nakano-sakaue on Marunouchi Line) should not include connecting railway info of Marunouchi Branch Line." do
            expect( nakano_sakaue_main.connecting_railway_lines ).not_to include( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
          end
        end

      end

      describe "方南町・中野富士見町・中野新橋" do

        describe "exist" do
          invalid_stations_on_main.each do | station_name , var |
            it "(the station info of #{station_name} on Marunouchi Line) should not be present." do
              expect( var ).to be_nil
            end
          end
        end

      end

    end


    describe "丸ノ内線（支線 / 方南町 - 中野坂上）" do

      describe "中野坂上" do
        describe "connecting_railway_lines" do
          # odpt.Railway:TokyoMetro.Marunouchi は含まれない
          it "(the station info of Nakano-sakaue on Marunouchi Branch Line) should include connecting railway info of Marunouchi Line." do
            expect( nakano_sakaue_branch.connecting_railway_lines ).not_to include( "odpt.Railway:TokyoMetro.Marunouchi" )
          end
        end
      end

      describe "方南町・中野富士見町・中野新橋" do
        describe "exist" do
          stations_on_branch.each do | station_name , var |
            it "(the station info of #{station_name} on Marunouchi Branch Line) should be present." do
              expect( var ).to be_present
            end
          end
        end

        describe "railway_line" do
          stations_on_branch.each do | station_name , var |
            it "(the station info of #{station_name} on Marunouchi Branch Line) should on Marunouchi Branch Line." do
              expect( var.railway_line ).to eq( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
            end
          end
        end

        describe "station_code" do
          stations_on_branch.each_with_index do | row , i |
            station_name , var = row
            it "(the station info of #{station_name} on Marunouchi Branch Line) should contain a station code \'m0#{ 3 + i }\'." do
              expect( var.station_code ).to eq( "m0#{ 3 + i }" )
            end
          end
        end
      end

    end

  end

end