# 丸ノ内線支線各駅の駅時刻表 - 名称、駅名、路線名の確認
# @note 方南町、中野富士見町、中野新橋と、中野坂上の方南町方面
def station_timetables_on_marunouchi_branch_line_stations

  ::TokyoMetro::Api.station_timetables.marunouchi_including_branch.select { | timetable |
    timetable.same_as?( /Honancho\.NakanoSakaue\Z/ , /Nakano(?:Fujimicho|Shimbashi)\.(?:Honancho|NakanoSakaue)\Z/ , /NakanoSakaue\.Honancho\Z/ )
  }.each do | timetable |

    # 正しい駅名は MarunouchiBranch.Xxxx の形になっている
    valid_timetable_name = timetable.same_as.gsub( /Marunouchi(?:Branch)?\./ , "MarunouchiBranch." )
    valid_station_name = timetable.station.gsub( /Marunouchi(?:Branch)?\./ , "MarunouchiBranch." )

    describe ::TokyoMetro::Api::StationTimetable::Info , "after converting invalid station name to in Marunouchi Branch Line" do
      it "should be \"#{ valid_timetable_name }\". \"#{ timetable.same_as }\" is not valid." do
        expect( timetable.same_as ).to match( /MarunouchiBranch\.[[:alpha:]]+\.[[:alpha:]]+\Z/ )
      end
      it "should be \"#{ valid_station_name }\". \"#{ timetable.station }\" is not valid." do
        expect( timetable.station ).to match( /MarunouchiBranch\.[[:alpha:]]+\Z/ )
      end
    end

    describe ::TokyoMetro::Api::StationTimetable::Info , "after converting railway line name" do
      it "(#{ timetable.same_as }) should be on Marunouchi Branch Line" do
        expect( timetable.railway_line ).to eq( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
      end
    end

  end

end