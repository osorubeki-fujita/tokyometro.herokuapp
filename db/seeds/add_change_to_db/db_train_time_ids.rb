__END__

#-------- 20141114_0407 千代田線北千住駅の駅時刻表 (DB) をチェック
def db_train_time_ids_of_chiyoda_line_kitasenju
  timetable_ids = ::Timetable.where(
    railway_id: ::Railway.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" ).id ,
    station_info_id: ::Station::Info.where( name_ja: "北千住" ).pluck( :id )
  )
  ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )
end

#-------- 20141115_0436 南北線各駅、武蔵小杉行きの列車情報
def db_train_time_ids_of_namboku_line_bound_for_musashi_kosugi
  namboku_line_timetable_ids = ::Timetable.where(
    railway_id: ::Railway.find_by( same_as: "odpt.Railway:TokyoMetro.Namboku" ).id
  )
  musashi_kosugi_ids = ::Station::Info.where( name_in_system: "MusashiKosugi" ).pluck( :id )
  to_station_info_ids = ::ToStation::Info.where( id: musashi_kosugi_ids ).pluck( :id )
  ::TrainTime.where( timetable_id: namboku_line_timetable_ids , to_station_info_id: to_station_info_ids ).pluck( :id )
end
