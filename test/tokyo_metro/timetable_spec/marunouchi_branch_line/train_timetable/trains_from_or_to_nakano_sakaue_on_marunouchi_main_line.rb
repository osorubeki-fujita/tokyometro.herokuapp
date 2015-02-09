def trains_from_or_to_nakano_sakaue_on_marunouchi_main_line
  train_ary_on_marunouchi_including_branch = ::TokyoMetro::Api.train_timetables.marunouchi_including_branch
  train_ary_of_marunouchi_branch_line_train_from_or_to_nakano_sakaue_on_main_line = train_ary_on_marunouchi_including_branch.select { | train |
    !( train.operated_only_on_marunouchi_branch_line? ) and ( train.starting_on_marunouchi_branch_line_including_invalid? or train.terminating_on_marunouchi_branch_line_including_invalid? ) and ( train.starting_at_nakano_sakaue? or train.terminate_at_nakano_sakaue? )
  }

  train_ary_of_marunouchi_branch_line_train_from_or_to_nakano_sakaue_on_main_line.each do | train |

    if /NakanoSakaue\Z/ === train.starting_station
      describe ::TokyoMetro::Api::TrainTimetable::Info , "Marunouchi Train from Nakano-sakaue" do
        it "should be operated on Marunouchi Main Line." do
          expect( train ).to be_on_marunouchi_line
        end
        it "should be start at Nakano-sakaue." do
          expect( train ).to be_starting_at_nakano_sakaue
        end
        it "should be start at Nakano-sakaue on Marunouchi Main Line." do
          expect( train ).to be_starting_at_nakano_sakaue_on_marunouchi_line
        end
      end
    end

    if /NakanoSakaue\Z/ === train.terminal_station
      describe ::TokyoMetro::Api::TrainTimetable::Info , "Marunouchi Train to Nakano-sakaue" do
        it "should be operated on Marunouchi Main Line." do
          expect( train ).to be_on_marunouchi_line
        end
        it "should be terminate at Nakano-sakaue." do
          expect( train ).to be_terminating_at_nakano_sakaue
        end
        it "should be terminate at Nakano-sakaue on Marunouchi Main Line." do
          expect( train ).to be_terminating_at_nakano_sakaue_on_marunouchi_line
        end
      end
    end

    check_stopping_stations_in_train_timetable( train , /Marunouchi\.[[:alpha:]]+\Z/ , "Marunouchi Main" )
  end

end