def trains_on_marunouchi_branch_line
  train_ary_on_marunouchi_including_branch = ::TokyoMetro::Api.train_timetables.marunouchi_including_branch

  numbers_of_marunouchi_line_trains_including_branch = ::TokyoMetro::Api.train_timetables.select { | item |
    /\Aodpt\.Railway\:TokyoMetro\.Marunouchi(?:Branch)?\Z/ === item.railway_line
  }.length

  # TokyoMetro::Api::TrainTimetable::List#marunouchi_including_branch により取得した列車の数と、
  # 路線名をもとに #select で取得した列車の数は同じでなければならない。
  describe ::TokyoMetro::Api::TrainTimetable::List , "- method for selecting Marunouchi and Marunouchi Branch Line trains" do
    it "(trains in Marunouchi and Marunouchi Branch Line)" do
      expect( train_ary_on_marunouchi_including_branch.length ).to eq( numbers_of_marunouchi_line_trains_including_branch )
    end
  end

  train_ary_on_marunouchi_including_branch.each do | train |
    describe ::TokyoMetro::Api::TrainTimetable::Info , "- trains on Marunouchi Branch Line" do

      # 始発駅
      describe "Starting Station" do

        if /Honancho\Z/ === train.starting_station
          it "(#{train.same_as}) should start at Honancho." do
            expect( train ).to be_starting_on_marunouchi_branch_line_including_invalid
            expect( train ).to be_starting_at_honancho_including_invalid
            expect( train ).to be_starting_at_honancho
          end
        end
        if /NakanoFujimicho\Z/ === train.starting_station
          it "(#{train.same_as}) should start at Nakano-fujimicho." do
            expect( train ).to be_starting_on_marunouchi_branch_line_including_invalid
            expect( train ).to be_starting_at_nakano_fujimicho_including_invalid
            expect( train ).to be_starting_at_nakano_fujimicho
          end
        end
        if /NakanoSakaue\Z/ === train.starting_station
          it "(#{train.same_as}) should start at Nakano-sakaue." do
            expect( train ).to be_starting_on_marunouchi_branch_line_including_invalid
            expect( train ).to be_starting_at_nakano_sakaue
          end
        end
        if /Marunouchi\.NakanoSakaue\Z/ === train.starting_station
          it "(#{train.same_as}) should start at Nakano-sakaue on Marunouchi Line." do
            expect( train ).to be_starting_at_nakano_sakaue_on_marunouchi_line
          end
        end
        if /MarunouchiBranch\.NakanoSakaue\Z/ === train.starting_station
          it "(#{train.same_as}) should start at Nakano-sakaue on Marunouchi Branch Line." do
            expect( train ).to be_starting_at_nakano_sakaue_on_marunouchi_branch_line
          end
        end

      end

      # 終着駅
      describe "Terminal Station" do

        if /Honancho\Z/ === train.terminal_station
          it "(#{train.same_as}) should terminate at Honancho." do
            expect( train ).to be_terminating_on_marunouchi_branch_line_including_invalid
          end
        end
        if /NakanoFujimicho\Z/ === train.terminal_station
          it "(#{train.same_as}) should terminate at Nakano-fujimicho." do
            expect( train ).to be_terminating_on_marunouchi_branch_line_including_invalid
          end
        end
        if /NakanoSakaue\Z/ === train.terminal_station
          it "(#{train.same_as}) should terminate at Nakano-sakaue." do
            expect( train ).to be_terminating_on_marunouchi_branch_line_including_invalid
            expect( train ).to be_terminating_at_nakano_sakaue
          end
        end
        if /Marunouchi\.NakanoSakaue\Z/ === train.terminal_station
          it "(#{train.same_as}) should terminate at Nakano-sakaue on Marunouchi Line." do
            expect( train ).to be_terminating_at_nakano_sakaue_on_marunouchi_line
          end
        end
        if /MarunouchiBranch\.NakanoSakaue\Z/ === train.terminal_station
          it "(#{train.same_as}) should terminate at Nakano-sakaue on Marunouchi Branch Line." do
            expect( train ).to be_terminating_at_nakano_sakaue_on_marunouchi_branch_line
          end
        end

      end

      # 路線名
      if train.starting_on_marunouchi_branch_line_including_invalid? and train.terminating_on_marunouchi_branch_line_including_invalid?
        describe "railway_line" do
          it "(#{train.same_as}) should on Marunouchi Branch Line." do
            expect( train.railway_line ).to match( /\Aodpt\.Railway\:TokyoMetro\.Marunouchi(?:Branch)\Z/ )
            expect( train ).to be_marunouchi_line_including_branch
            expect( train ).to be_operated_only_on_marunouchi_branch_line_including_invalid

            expect( train.railway_line ).to eq( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
            expect( train ).to be_marunouchi_branch_line
            expect( train ).to be_operated_only_on_marunouchi_branch_line
          end
        end
      end

    end
  end
end