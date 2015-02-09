def relations_of_all_trains_between_nakano_fujimicho_and_ogikubo( ary )
  ary.each do | train_number_pair |
    train_number_to_nakano_sakaue , train_number_from_nakano_sakaue = train_number_pair

    train_timetable_to_nakano_sakaue = ::TokyoMetro::Api.train_timetables.find { | item | item.same_as?( train_number_to_nakano_sakaue ) }
    train_timetable_from_nakano_sakaue = ::TokyoMetro::Api.train_timetables.find { | item | item.same_as?( train_number_from_nakano_sakaue ) }

    describe ::TokyoMetro::Api::TrainTimetable::Info , "of trains between Nakano-fujimicho and Ogikubo" do

      it "(#{train_number_to_nakano_sakaue}) should be followed by #{train_number_from_nakano_sakaue}" do
        expect( train_timetable_to_nakano_sakaue.following_train ).to eq( train_number_from_nakano_sakaue )
        expect( train_timetable_to_nakano_sakaue.following_train_in_api ).to be_instance_of( ::TokyoMetro::Api::TrainTimetable::Info )
      end

      it "(#{train_number_from_nakano_sakaue}) should be preceded by #{ train_number_to_nakano_sakaue }" do
        expect( train_timetable_from_nakano_sakaue.previous_train ).to eq( train_number_to_nakano_sakaue )
        expect( train_timetable_from_nakano_sakaue.previous_train_in_api ).to be_instance_of( ::TokyoMetro::Api::TrainTimetable::Info )
      end

    end
  end
end