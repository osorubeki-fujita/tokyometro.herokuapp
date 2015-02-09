def marunouchi_branch_line_train_from_or_to_ikebukuro
  train_ary_on_marunouchi_including_branch = ::TokyoMetro::Api.train_timetables.marunouchi_including_branch

  train_ary_of_marunouchi_branch_line_train_from_or_to_ikebukuro = train_ary_on_marunouchi_including_branch.select { | train |
    !( train.operated_only_on_marunouchi_branch_line? ) and ( train.starting_on_marunouchi_branch_line_including_invalid? or train.terminating_on_marunouchi_branch_line_including_invalid? ) and !( train.starting_at_nakano_sakaue? ) and !( train.terminate_at_nakano_sakaue? )
  }

  train_ary_of_marunouchi_branch_line_train_from_or_to_ikebukuro.each do | train |

    describe ::TokyoMetro::Api::TrainTimetable::Info , "Marunouchi Branch Train from or to Ikebukuro" do
      it "should be operated on Marunouchi Main and Branch Line." do
        expect( train ).to be_operated_on_marunouchi_main_and_branch_line
      end
    end

    describe ::TokyoMetro::Api::TrainTimetable::Info , "Marunouchi Branch Train from or to Ikebukuro" do
      it "should not start at Ogikubo." do
        expect( train.starting_station ).not_to eq( "odpt.Station:TokyoMetro.Marunouchi.Ogikubo" )
      end
      it "should not terminate at Ogikubo." do
        expect( train.terminal_station ).not_to eq( "odpt.Station:TokyoMetro.Marunouchi.Ogikubo" )
      end
    end

    if train.starting_on_marunouchi_branch_line_including_invalid?
      describe ::TokyoMetro::Api::TrainTimetable::Info , "Marunouchi Branch Train from Nakano-fujimicho" do
        it "should start at Nakano-fujimicho. \"#{train.starting_station}\" is not valid." do
          expect( train.starting_station ).to eq( "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho" )
        end
        it "should start at Nakano-fujimicho." do
          expect( train ).to be_starting_on_marunouchi_branch_line
        end
        it "should not start at Nakano-sakaue." do
          expect( train ).not_to be_starting_at_nakano_sakaue
        end
      end
      check_stopping_stations_in_train_timetable( train , /MarunouchiBranch\.Nakano(?:Fujimicho|Shimbashi)\Z/ , "Marunouchi Main" , /Marunouchi(?:Branch)?\.Nakano(?:Fujimicho|Shimbashi)\Z/ )
      check_stopping_stations_in_train_timetable( train , /Marunouchi\.NakanoSakaue+\Z/ , "Marunouchi Main" , /Marunouchi(?:Branch)?\.NakanoSakaue\Z/ )
    end

    if train.terminating_on_marunouchi_branch_line_including_invalid?
      describe ::TokyoMetro::Api::TrainTimetable::Info , "Marunouchi Branch Train to Nakano-fujimicho" do
        it "should terminate at Nakano-fujimicho. \"#{train.terminal_station}\" is not valid." do
          expect( train.terminal_station ).to eq( "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoFujimicho" )
        end
        it "should terminate at Nakano-fujimicho." do
          expect( train ).to be_terminating_on_marunouchi_branch_line
        end
        it "should not terminate at Nakano-sakaue." do
          expect( train ).not_to be_terminating_at_nakano_sakaue
        end
      end
      check_stopping_stations_in_train_timetable( train , /MarunouchiBranch\.Nakano(?:Fujimicho|Shimbashi)\Z/ , "Marunouchi Main" , /Marunouchi(?:Branch)?\.Nakano(?:Fujimicho|Shimbashi)\Z/ )
      check_stopping_stations_in_train_timetable( train , /MarunouchiBranch\.NakanoSakaue+\Z/ , "Marunouchi Main" , /Marunouchi(?:Branch)?\.NakanoSakaue\Z/ )
    end

  end

end