def infos_of_trains_from_ogikubo_to_nakano_fujimicho( ary )
  ary.each do | train_number_pair |
    train_number_to_nakano_sakaue , train_number_from_nakano_sakaue = train_number_pair

    train_timetable_to_nakano_sakaue = ::TokyoMetro::Api.train_timetables.find { | item | item.same_as?( train_number_to_nakano_sakaue ) }
    train_timetable_from_nakano_sakaue = ::TokyoMetro::Api.train_timetables.find { | item | item.same_as?( train_number_from_nakano_sakaue ) }

    describe ::TokyoMetro::Api::TrainTimetable::Info , "of trains from Ogikubo to Nakano-fujimicho" do

      it "(#{train_number_to_nakano_sakaue}) should terminate at Nakano-sakaue." do
        expect( train_timetable_to_nakano_sakaue.valid_list.last.arrival_station ).to eq( "odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue" )
        expect( train_timetable_to_nakano_sakaue.terminal_station ).to eq( "odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue" )
      end

      it "(#{train_number_from_nakano_sakaue}) should start at Nakano-sakaue." do
        expect( train_timetable_from_nakano_sakaue.valid_list.first.departure_station ).to eq( "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue" )
        expect( train_timetable_from_nakano_sakaue.starting_station ).to eq( "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue" )
      end

      #--------

      it "(#{train_number_to_nakano_sakaue}) should start at Ogikubo in system" do
        expect( train_timetable_to_nakano_sakaue ).to be_starting_at_ogikubo
      end

      it "(#{train_number_to_nakano_sakaue}) should terminate at Nakano-sakaue in system" do
        expect( train_timetable_to_nakano_sakaue ).to be_terminating_at_nakano_sakaue_on_marunouchi_line
      end

      it "(#{train_number_from_nakano_sakaue}) should start at Nakano-sakaue in system" do
        expect( train_timetable_from_nakano_sakaue ).to be_starting_at_nakano_sakaue_on_marunouchi_branch_line
      end

      it "(#{train_number_from_nakano_sakaue}) should terminate at Nakano-fujimicho in system" do
        expect( train_timetable_from_nakano_sakaue ).to be_terminate_at_nakano_fujimicho
      end

      #--------

      it "(#{train_number_to_nakano_sakaue}) should go for Nakano-sakaue" do
        expect( train_timetable_to_nakano_sakaue.railway_direction ).to eq( "odpt.RailDirection:TokyoMetro.NakanoSakaue" )
      end

      it "(#{train_number_from_nakano_sakaue}) should go for Ogikubo" do
        expect( train_timetable_from_nakano_sakaue.railway_direction ).to eq( "odpt.RailDirection:TokyoMetro.Honancho" )
      end

      #--------

      it "(#{train_number_to_nakano_sakaue}) should be on Marunouchi Line" do
        expect( train_timetable_to_nakano_sakaue.railway_line ).to eq( "odpt.Railway:TokyoMetro.Marunouchi" )
      end

      it "(#{train_number_from_nakano_sakaue}) should be on Marunouchi Branch Line" do
        expect( train_timetable_from_nakano_sakaue.railway_line ).to eq( "odpt.Railway:TokyoMetro.MarunouchiBranch" )
      end

      #--------

      it "(#{train_number_to_nakano_sakaue}) should start at Ogikubo on actual" do
        expect( train_timetable_to_nakano_sakaue ).to be_actually_starting_at_ogikubo
      end

      it "(#{train_number_to_nakano_sakaue}) should terminate at Nakano-fujimicho on actual" do
        expect( train_timetable_to_nakano_sakaue ).to be_actually_terminate_at_nakano_fujimicho
      end

      it "(#{train_number_from_nakano_sakaue}) should start at Ogikubo on actual" do
        expect( train_timetable_from_nakano_sakaue ).to be_actually_starting_at_ogikubo
      end

      it "(#{train_number_from_nakano_sakaue}) should terminate at Nakano-fujimicho on actual" do
        expect( train_timetable_from_nakano_sakaue ).to be_actually_terminate_at_nakano_fujimicho
      end

    end
  end
end