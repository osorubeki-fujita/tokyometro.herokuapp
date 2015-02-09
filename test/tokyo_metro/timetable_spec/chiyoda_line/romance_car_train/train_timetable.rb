def romance_car_train
  ::TokyoMetro::Api.train_timetables.chiyoda.select { | item | item.romance_car_on_chiyoda_line? }.each do | train |
    valid_train_type = ::TokyoMetro::CommonModules::Dictionary::RomanceCar.train_type[ train.same_as ]

    describe ::TokyoMetro::Api::TrainTimetable::Info , "of train type of Romance Car in Chiyoda Line" do
      it "(#{ train.same_as }) should be \"#{ valid_train_type }\". \"#{ train.train_type }\" (\"#{ train.train_name }\") is not valid." do
        expect( train.train_type ).to eq( "odpt.TrainType:TokyoMetro.RomanceCar" )
        expect( train.train_name ).to eq( valid_train_type )
      end
    end

  end
end