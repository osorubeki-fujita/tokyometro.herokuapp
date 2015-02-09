def train_timetable_starting_station
  ::TokyoMetro::Api.train_timetables.each do | train |
    describe ::TokyoMetro::Api::TrainTimetable::Info , "starting station" do
      it "should contain an information of starting station." do
        expect( train.starting_station ).to be_present
        expect( train.starting_station.class ).to eq( ::String )
      end
    end
  end
end