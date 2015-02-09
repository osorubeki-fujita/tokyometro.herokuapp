require_relative 'fundamental_settings.rb'


::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )

Dir.glob( "#{File.dirname(__FILE__)}/#{File.basename( __FILE__ , ".*" )}/**/**.rb" ).each do | file |
  require file
end

#--------

#train_timetable_starting_station

#fundamental_infos_of_station_timetables
#additional_infos_of_station_timetables

#-------- marunouchi_branch_line

# station_timetable

#station_timetables_on_marunouchi_branch_line_stations
#nakano_sakaue_on_marunouchi_branch_line_in_station_timetables

# train_timetable

#trains_from_or_to_nakano_sakaue_on_marunouchi_main_line
#trains_on_marunouchi_branch_line
#trains_operated_only_on_marunouchi_branch_line

#marunouchi_branch_line_train_from_or_to_ikebukuro
#marunouchi_branch_line_train_from_or_to_ogikubo

#-------- chiyoda_line

#station_timetable_on_chiyoda_branch_line
#train_timetable_on_chiyoda_branch_line
#romance_car_train

#-------- namboku_and_toei_mita_line

#musashi_kosugi_on_tokyu_meguro_line
trains_on_toei_mita_line

#-------- yurakucho_and_fukutoshin_line

#wakoshi_on_yurakucho_line
#wakoshi_on_fukutoshin_line
#invalid_trains_in_yurakucho_line