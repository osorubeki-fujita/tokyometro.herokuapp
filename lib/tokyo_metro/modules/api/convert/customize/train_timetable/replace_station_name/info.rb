module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::ReplaceStationName::Info

  private

  def replace_station_name( regexp_for_replaced_station , replacing_string )
    self.timetables.each do | timetable |
      if timetable.present?
        timetable.each do | station_time |

          [ :arrival_station , :departure_station ].each do | method |
            station_name = station_time.send( method )
            if station_name.present? and regexp_for_replaced_station === station_name
              station_time.instance_eval do
                eval <<-REPLACE
                  @#{method} = station_name.gsub( regexp_for_replaced_station , replacing_string )
                REPLACE
              end
            end
          end

        end
      end
    end
  end

end