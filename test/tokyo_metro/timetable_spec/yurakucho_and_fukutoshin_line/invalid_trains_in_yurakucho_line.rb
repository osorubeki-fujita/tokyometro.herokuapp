module TokyoMetro

  module Test

    module FukutoshinLineStation

      def fukutoshin_line_station_or_nil?
        self.nil? or /\Aodpt\.Station\:TokyoMetro\.Fukutoshin/ === self
      end

    end

  end

end


def invalid_trains_in_yurakucho_line
  ::TokyoMetro::ApiModules::Convert::Patches::TrainTimetable::YurakuchoLine.invalid_trains.each do | train_number |
    train = ::TokyoMetro::Api.train_timetables.find { | train |
      train.fukutoshin_line? and train.operated_on_weekdays? and train.train_number == train_number
    }
    if train.nil?
      raise "Error: \"#{ train_number }\" does not exist in the array."
    end

    train.weekdays.each do | station |
      arrival_station = station.arrival_station
      departure_station = station.departure_station

      [ arrival_station , departure_station ].each do | var |
        class << var
          include ::TokyoMetro::Test::FukutoshinLineStation
        end
      end

      describe ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info , "after processing invalid trains in \"#{train_number}\" Yurakucho and Fukutoshin Line" do

        [ arrival_station , departure_station ].each do | var |
          it "should be a station in Fukutoshin Line or nil" do
            expect( var ).to be_fukutoshin_line_station_or_nil
          end
        end

      end
    end

  end

end