def trains_on_toei_mita_line
  train_ary_on_namboku_line = ::TokyoMetro::Api.train_timetables.namboku_and_toei_mita
  
  train_ary_on_namboku_line.each do | train |
    if /Toei\.Mita/ === train.starting_station or /Toei\.Mita/ === train.terminal_station
      describe ::TokyoMetro::Api::TrainTimetable::Info , "after converting railway line info" do
        it "(#{train.same_as}) should be on Toei Mita Line." do
          expect( train ).to be_toei_mita_line_train_including_on_namboku_line
          expect( train ).to be_on_namboku_or_toei_mita_line
          expect( train ).to be_on_toei_mita_line
          expect( train.operator ).to eq( "odpt.Operator:Toei" )
          expect( train.train_type ).to match( /\Aodpt.TrainType\:Toei\.(?:Local|Express)\Z/ )
        end
      end
      check_stopping_stations_in_train_timetable( train , /Toei\.Mita\.(?:Meguro|Shirokane(?:dai|Takanawa))\Z/ , "Toei Mita" )
    end
  end
  
end