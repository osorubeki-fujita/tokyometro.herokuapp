require_relative '../fundamental_settings.rb'

::TokyoMetro.set_api_constants( { station_timetable: true } )
# ::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )

def nakano_sakaue_on_marunouchi_branch_line
  timetables_between_honancho_and_nakano_shimbashi = ::TokyoMetro::Api.station_timetables.select { | timetable |
    timetable.marunouchi_line_including_branch? and timetable.between_honancho_and_nakano_shimbashi?
  }

  timetables_between_honancho_and_nakano_shimbashi.each do | timetable |

    describe ::TokyoMetro::Api::StationTimetable::Info , "after converting invalid station name to in Marunouchi Branch Line" do
      before do
        @station_name = timetable.station
        @valid_station_name = @station_name.gsub( /Marunouchi(?:Branch)?\./ , "MarunouchiBranch." )
      end
      it "should be \"#{ @valid_station_name }\". \"#{ @station_name }\" is not valid." do
        expect( @station_name ).to match( /MarunouchiBranch/ )
      end
      after do
        @station_name = nil
        @valid_station_name = nil
      end
    end

    timetable.timetables.each do | t |
      t.each do | train |

        if train.terminate_at_nakano_sakaue?

          describe ::TokyoMetro::Api::StationTimetable::Info::Train::Info , "after converting invalid terminal station name \"Marunouchi.NakanoSakaue\"" do
            before do
              @terminal_station_name = train.terminal_station
              @valid_terminal_station_name = @terminal_station_name.gsub( /Marunouchi(?:Branch)?\./ , "MarunouchiBranch." )
            end
            it "should be \"#{ @valid_terminal_station_name }\". \"#{ @terminal_station_name }\" is not valid." do
              expect( @terminal_station_name ).to match( /MarunouchiBranch/ )
            end
            after do
              @terminal_station_name = nil
              @valid_terminal_station_name = nil
            end
          end

        end

      end
    end

  end

end

nakano_sakaue_on_marunouchi_branch_line