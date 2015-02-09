def trains_operated_only_on_marunouchi_branch_line
  train_ary_on_marunouchi_including_branch = ::TokyoMetro::Api.train_timetables.marunouchi_including_branch
  train_ary_operated_only_on_marunouchi_branch_line = train_ary_on_marunouchi_including_branch.select { | train |
    train.operated_only_on_marunouchi_branch_line_including_invalid?
  }

  regexp_for_test = /\Aodpt.Station:TokyoMetro.MarunouchiBranch\.(?:Honancho|Nakano(?:Fujimicho|Shimbashi|Sakaue))\Z/

  train_ary_operated_only_on_marunouchi_branch_line.each do | train |

    describe ::TokyoMetro::Api::TrainTimetable::Info , "after converting railway line name" do
      it "(#{train.same_as}) should be on Marunouchi Branch Line." do
        expect( train.railway_line ).to eq( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
      end
      it "(#{train.same_as}) should start at a station on Marunouchi Branch Line." do
        expect( train.starting_station ).to match( regexp_for_test )
      end
      it "(#{train.same_as}) should terminate at a station on Marunouchi Branch Line." do
        expect( train.terminal_station ).to match( regexp_for_test )
      end
      it "(#{train.same_as}) should be on Marunouchi Branch Line." do
        expect( train ).to be_operated_only_on_marunouchi_branch_line
      end
    end

    check_stopping_stations_in_train_timetable( train , regexp_for_test , "Marunouchi Branch" )
  end

end