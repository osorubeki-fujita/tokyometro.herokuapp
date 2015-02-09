def train_timetable_on_chiyoda_branch_line
  train_ary_on_chiyoda = ::TokyoMetro::Api.train_timetables.chiyoda_including_branch
  train_ary_operated_only_on_chiyoda_branch_line = train_ary_on_chiyoda.select { | train | train.operated_only_on_chiyoda_branch_line_including_invalid? }

  # 列車時刻表

  regexp_for_test = /\Aodpt.Station:TokyoMetro.ChiyodaBranch\.(?:Kita)?Ayase\Z/
  train_ary_operated_only_on_chiyoda_branch_line.each do | train |

    describe ::TokyoMetro::Api::TrainTimetable::Info , "after converting railway line name" do
      it "(#{train.same_as}) should be on Chiyoda Branch Line." do
        expect( train.railway_line ).to eq( "odpt.Railway:TokyoMetro.ChiyodaBranch" )
      end
      it "(#{train.same_as}) should start at a station on Chiyoda Branch Line." do
        expect( train.starting_station ).to match( regexp_for_test )
      end
      it "(#{train.same_as}) should terminate at a station on Chiyoda Branch Line." do
        expect( train.terminal_station ).to match( regexp_for_test )
      end
      it "(#{train.same_as}) should be on Chiyoda Branch Line." do
        expect( train ).to be_operated_only_on_chiyoda_branch_line
      end
    end

    check_stopping_stations_in_train_timetable( train , regexp_for_test , "Chiyoda Branch" )
  end
end