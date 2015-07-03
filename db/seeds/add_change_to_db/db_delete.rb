__END__

#-------- 20141114_1851 銀座線稲荷町駅の駅時刻表を削除
def db_delete_train_times_of_ginza_line_inaricho
  timetable_ids = ::Timetable.where( station_info_id: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Ginza.Inaricho" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#-------- 20141114_0406 千代田線北千住駅の駅時刻表を削除
def db_delete_train_times_of_chiyoda_line_kitasenju
  timetable_ids = ::Timetable.where( station_info_id: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Chiyoda.KitaSenju" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#--------20141201_2209 千代田線各駅の駅時刻表を削除
def db_delete_train_times_of_chiyoda_line
  timetable_ids = ::Timetable.where( railway_id: ::Railway.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#-------- 20141202_0756 半蔵門線神保町駅の駅時刻表を削除
def db_delete_train_times_of_hanzomon_line_jimbocho
  timetable_ids = ::Timetable.where( station_info_id: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Hanzomon.Jimbocho" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#-------- 20141115_0648 有楽町線小竹向原駅の駅時刻表を削除
def db_delete_train_times_of_yurakucho_line_kotake_mukaihara
  timetable_ids = ::Timetable.where( station_info_id: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#-------- 20141115_0702 有楽町線和光市駅・有楽町駅の駅時刻表を削除
def db_delete_train_times_of_yurakucho_line_wakoshi_and_yurakucho
  timetable_ids = ::Timetable.where( station_info_id: ::Station::Info.where( same_as: [ "odpt.Station:TokyoMetro.Yurakucho.Wakoshi" , "odpt.Station:TokyoMetro.Yurakucho.Yurakucho" ] ).pluck( :id ) ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#-------- 20141115_0139 南北線目黒駅の駅時刻表を削除
def db_delete_train_times_of_namboku_line_meguro
  timetable_ids = ::Timetable.where( station_info_id: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Namboku.Meguro" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#-------- 20141115_0333 南北線白金台駅の駅時刻表を削除
def db_delete_train_times_of_namboku_line_shirokanedai
  timetable_ids = ::Timetable.where( station_info_id: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Namboku.Shirokanedai" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end

#--------20141114_0016 副都心線各駅の駅時刻表を削除
def db_delete_train_times_of_fukutoshin_line
  timetable_ids = ::Timetable.where( railway_id: ::Railway.find_by( same_as: "odpt.Railway:TokyoMetro.Fukutoshin" ).id ).pluck( :id )
  train_time_ids = ::TrainTime.where( timetable_id: timetable_ids ).pluck( :id )

  ::Timetable.destroy_all( id: timetable_ids )
  ::TrainTime.destroy_all( id: train_time_ids )
  return nil
end
