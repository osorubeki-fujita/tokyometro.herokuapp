def marunouchi_branch_line
  marunouchi_line = ::TokyoMetro::Api.railway_lines.find { | item | /Marunouchi\Z/ === item.same_as }
  marunouchi_branch_line = ::TokyoMetro::Api.railway_lines.find { | item | /MarunouchiBranch\Z/ === item.same_as }

  describe ::TokyoMetro::Api::RailwayLine::List , "check Marunouchi Main Line" do

    describe "丸ノ内線（本線 / 荻窪 - 池袋）" do

      describe "exist" do
        it "(instance of Marunouchi Line) should exist." do
          expect( marunouchi_line ).to be_present
        end
      end

      describe "same_as" do
        it "(instance variable \'same_as\') should be \"odpt.Railway:TokyoMetro.Marunouchi\"." do
          expect( marunouchi_line.same_as ).to eq( "odpt.Railway:TokyoMetro.Marunouchi" )
        end
      end

      describe "station_order" do
        marunouchi_line.station_order.each do | info |
          it "(station order info) should be on Marunouchi Main Line." do
            expect( info.station ).to match( /Marunouchi\.[[:alpha:]]+\Z/ )
            expect( info.station ).not_to match( /(?:Nakano(?:Shimbashi|Fujimicho)|Honancho)/ )
          end
        end
      end

      describe "travel_time" do
        marunouchi_line.travel_time.each do | info |
          [ info.from_station , info.to_station ].each do | station |
            it "(travel time info) should be on Marunouchi Main Line." do
              expect( station ).to match( /Marunouchi\.[[:alpha:]]+\Z/ )
              expect( station ).not_to match( /(?:Nakano(?:Shimbashi|Fujimicho)|Honancho)/ )
            end
          end
        end
      end

    end

    describe ::TokyoMetro::Api::RailwayLine::List , "check Marunouchi Branch Line" do

      describe "丸ノ内線（支線 / 方南町 - 中野坂上）" do

        describe "exist" do
          it "(instance of Marunouchi Branch Line) should exist." do
            expect( marunouchi_branch_line ).to be_present
          end
        end

        describe "same_as" do
          it "(instance variable \'same_as\') should be \"odpt.Railway:TokyoMetro.MarunouchiBranch\"." do
            expect( marunouchi_branch_line.same_as ).to eq( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
          end
        end

        describe "station_order" do
          marunouchi_branch_line.station_order.each do | info |
            it "(station order info) should be on Marunouchi Branch Line." do
              expect( info.station ).to match( /MarunouchiBranch\.[[:alpha:]]+\Z/ )
              expect( info.station ).to match( /(?:Nakano(?:Sakaue|Shimbashi|Fujimicho)|Honancho)\Z/ )
            end
          end
        end

        describe "travel_time" do
          marunouchi_branch_line.travel_time.each do | info |
            [ info.from_station , info.to_station ].each do | station |
              it "(travel time info) should be on Marunouchi Main Line." do
                expect( station ).to match( /MarunouchiBranch\.[[:alpha:]]+\Z/ )
                expect( station ).to match( /(?:Nakano(?:Sakaue|Shimbashi|Fujimicho)|Honancho)\Z/ )
              end
            end
          end
        end

      end

    end

  end

end