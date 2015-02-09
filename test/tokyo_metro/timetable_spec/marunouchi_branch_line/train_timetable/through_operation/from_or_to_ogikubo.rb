require_relative 'from_or_to_ogikubo/relations_of_all_trains_between_nakano_fujimicho_and_ogikubo.rb'
require_relative 'from_or_to_ogikubo/infos_of_trains_from_nakano_fujimicho_to_ogikubo.rb'
require_relative 'from_or_to_ogikubo/infos_of_trains_from_ogikubo_to_nakano_fujimicho.rb'

def marunouchi_branch_line_train_from_or_to_ogikubo
  from_nakano_fujimicho_to_ogikubo = [
    [ "odpt.TrainTimetable:TokyoMetro.Marunouchi.B05531.Weekdays" , "odpt.TrainTimetable:TokyoMetro.Marunouchi.A0553.Weekdays" ] ,
    [ "odpt.TrainTimetable:TokyoMetro.Marunouchi.B05371.SaturdaysHolidays" , "odpt.TrainTimetable:TokyoMetro.Marunouchi.A0537.SaturdaysHolidays" ]
  ]

  from_ogikubo_to_nakano_fujimicho = [
    [ "odpt.TrainTimetable:TokyoMetro.Marunouchi.B2405.Weekdays" , "odpt.TrainTimetable:TokyoMetro.Marunouchi.A2405.Weekdays" ] ,
    [ "odpt.TrainTimetable:TokyoMetro.Marunouchi.B2475.Weekdays" , "odpt.TrainTimetable:TokyoMetro.Marunouchi.A2475.Weekdays" ] ,
    [ "odpt.TrainTimetable:TokyoMetro.Marunouchi.B2429.Weekdays" , "odpt.TrainTimetable:TokyoMetro.Marunouchi.A2429.Weekdays" ]
  ]

  relations_of_all_trains_between_nakano_fujimicho_and_ogikubo( from_nakano_fujimicho_to_ogikubo + from_ogikubo_to_nakano_fujimicho )
  infos_of_trains_from_nakano_fujimicho_to_ogikubo( from_nakano_fujimicho_to_ogikubo )
  infos_of_trains_from_ogikubo_to_nakano_fujimicho( from_ogikubo_to_nakano_fujimicho )
end