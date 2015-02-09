def check_terminal_station_of_each_train_in_station_timetables( method_for_select_station_timetables , module_name , method_for_check_terminal_station )
  station_timetables = ::TokyoMetro::Api.station_timetables.send( method_for_select_station_timetables )
  station_name = module_name::NAME
  regexp = module_name::REGEXP

  station_timetables.each do | station_timetable |
    station_timetable.combination_of_timetable_types_and_operation_days.each do | train_list , operation_day |

      train_list.each do | train_info |

        if regexp === train_info.terminal_station

          describe ::TokyoMetro::Api::StationTimetable::Info::Train::Info , "after converting invalid terminal station name to \"#{ station_name }\" in #{ method_for_select_station_timetables.to_s.capitalize } Line" do
            before do
              @terminal_station = train_info.terminal_station
              eval <<-INCLUDE
                class << @terminal_station
                  include #{module_name.name}
                end
              INCLUDE
            end
            it "should be \"#{ station_name }\"." do
              expect( @terminal_station ).to eval( method_for_check_terminal_station.to_s )
            end
            after do
              @terminal_station = nil
            end
          end

        end

      end

    end
  end

end

def check_starting_and_terminal_station_of_each_train_in_train_timetables( method_for_select_station_timetables , module_name , method_for_check_station )
  train_timetables = ::TokyoMetro::Api.train_timetables.send( method_for_select_station_timetables )
  station_name = module_name::NAME
  regexp = module_name::REGEXP

  train_timetables.each do | train_timetable |
    if regexp === train_timetable.starting_station
      describe train_timetable.starting_station , "after converting invalid starting station \"#{ station_name }\" in #{ method_for_select_station_timetables.to_s.capitalize } Line" do

        before do
          @starting_station = train_timetable.starting_station
          eval <<-INCLUDE
            class << @starting_station
              include #{module_name.name}
            end
          INCLUDE
        end
        it "should be \"#{ station_name }\"." do
          expect( @starting_station ).to eval( method_for_check_station.to_s )
        end
        after do
          @starting_station = nil
        end

      end
    end

    if regexp === train_timetable.terminal_station
      describe train_timetable.terminal_station , "after converting invalid terminal station \"#{ station_name }\" in #{ method_for_select_station_timetables.to_s.capitalize } Line" do

        before do
          @terminal_station = train_timetable.terminal_station
          eval <<-INCLUDE
            class << @terminal_station
              include #{ module_name.name }
            end
          INCLUDE
        end
        it "should be \"#{ station_name }\"." do
          expect( @terminal_station ).to eval( method_for_check_station.to_s )
        end
        after do
          @terminal_station = nil
        end

      end
    end

  end

end


def check_station_of_each_train_in_station_and_train_timetables( method_for_select_station_timetables , module_name , method_for_check_station )
  check_terminal_station_of_each_train_in_station_timetables( method_for_select_station_timetables , module_name , method_for_check_station )
  check_starting_and_terminal_station_of_each_train_in_train_timetables( method_for_select_station_timetables , module_name , method_for_check_station )
end


def check_stopping_stations_in_train_timetable( train , regexp , railway_line_name , regexp_for_select_station = nil )

  train.timetables.each do | timetable |
    if timetable.present?
      timetable.each do | station_time |

        [ :arrival_station , :departure_station ].each do | method |
          station_name = station_time.send( method )

          if station_name.present?
            if regexp_for_select_station.nil?
              check_stopping_stations_in_train_timetable_sub( train , station_name , regexp , railway_line_name , method )
            elsif regexp_for_select_station === station_name
              check_stopping_stations_in_train_timetable_sub( train , station_name , regexp , railway_line_name , method )
            end
          end

        end

      end
    end
  end

end

def check_stopping_stations_in_train_timetable_sub( train , station_name , regexp , railway_line_name , method )
  describe ::TokyoMetro::Api::TrainTimetable::Info , "after converting station name" do
    it "(#{method} of station time at #{station_name} for #{train.same_as}) should be on #{railway_line_name} Line." do
      expect( station_name ).to match( regexp )
    end
  end
end