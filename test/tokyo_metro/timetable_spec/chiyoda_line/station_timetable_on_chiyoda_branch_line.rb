# 駅時刻表
def station_timetable_on_chiyoda_branch_line

  ::TokyoMetro::Api.station_timetables.chiyoda_including_branch.select { | timetable |
    timetable.same_as?( /(?:Ayase\.KitaAyase|KitaAyase\.Ayase)\Z/ )
  }.each do | timetable |
    describe ::TokyoMetro::Api::StationTimetable::Info , "after converting railway line name" do
      it "(#{timetable.same_as}) should be on Chiyoda Branch Line" do
        expect( timetable.same_as ).to match( /ChiyodaBranch/ )
        expect( timetable.railway_line ).to eq( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
      end
    end
  end

end