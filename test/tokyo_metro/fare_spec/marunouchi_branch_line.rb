def marunouchi_branch_line
  valid_and_invalid_station_name_ary = ::TokyoMetro::CommonModules::Dictionary::Station::StringList.between_honancho_and_nakano_shimbashi
  invalid_station_name_ary = [ :honancho , :nakano_fujimicho , :nakano_shimbashi ].map { | method_base_name |
    ::TokyoMetro::CommonModules::Dictionary::Station::StringInfo.send( "#{ method_base_name.to_s }_invalid" )
  }

  ::TokyoMetro::Api.fares.each do | fare_info |

    if fare_info.from?( valid_and_invalid_station_name_ary )
      describe ::TokyoMetro::Api::Fare::Info , "after converting invalid \'from\' station name in Marunouchi Branch Line" do

        before do
          @from_station = fare_info.from
          @valid_station_name = @from_station.gsub( /Marunouchi(?:Branch)?\./ , "MarunouchiBranch." )
        end

        # 出発駅
        it "should be \"#{ @valid_station_name }\". \"#{ @from_station }\" in \"#{ fare_info.same_as }\" is not valid." do
          expect( @from_station ).to eq( @valid_station_name )
        end

        after do
          @from_station = nil
          @valid_station_name = nil
        end

      end
    end

    if fare_info.to?( valid_and_invalid_station_name_ary )
      describe ::TokyoMetro::Api::Fare::Info , "after converting invalid \'to\' station name in Marunouchi Branch Line" do

        before do
          @to_station = fare_info.to
          @valid_station_name = @to_station.gsub( /Marunouchi(?:Branch)?\./ , "MarunouchiBranch." )
        end

        # 到着駅
        it "should be \"#{ @valid_station_name }\". \"#{ @to_station }\" in \"#{ fare_info.same_as }\" is not valid." do
          expect( @to_station ).to eq( @valid_station_name )
        end

        after do
          @to_station = nil
          @valid_station_name = nil
        end

      end
    end

  end

end