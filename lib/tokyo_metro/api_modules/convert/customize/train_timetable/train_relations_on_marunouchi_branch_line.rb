module TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine

  def self.set_modules
    ::TokyoMetro::Api::TrainTimetable::Info.class_eval do
      include ::TokyoMetro::ApiModules::Info::Decision::ActualStartingStation
      include ::TokyoMetro::ApiModules::Info::Decision::ActualTerminalStation

      include ::TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Dictionary
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Info
    end

    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::List.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Info::StationTime::List
    end

    ::TokyoMetro::Api::TrainTimetable::Info::StationTime::Info.class_eval do
      prepend ::TokyoMetro::ApiModules::Convert::Customize::TrainTimetable::TrainRelationsOnMarunouchiBranchLine::Info::StationTime::Info
    end
  end

end

__END__

TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.B05531.Weekdays" }.valid_list.last
TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.A0553.Weekdays" }.valid_list.first

TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.B05531.Weekdays" }.actual_starting_stations
TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.A0553.Weekdays" }.actual_starting_stations

TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.B05531.Weekdays" }.actual_terminal_stations
TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.A0553.Weekdays" }.actual_terminal_stations

TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.B05531.Weekdays" }.starting_station
TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.A0553.Weekdays" }.starting_station

TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.B05531.Weekdays" }.terminal_station
TokyoMetro::Api.train_timetables.find { | item | item.same_as == "odpt.TrainTimetable:TokyoMetro.Marunouchi.A0553.Weekdays" }.terminal_station