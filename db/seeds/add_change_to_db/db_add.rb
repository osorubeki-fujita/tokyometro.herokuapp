#-------- 20141114_2059 半蔵門線、日比谷線、丸ノ内線、南北線、東西線、有楽町線の時刻表を追加
def db_add_train_times_of_zhmnty
  timetables = ::TokyoMetro::Api.timetables
  railways = [ "Hanzomon" , "Hibiya" , "Marunouchi" , "MarunouchiBranch" , "Namboku" , "Tozai" , "Yurakucho" ].map { | str | "odpt.Railway:TokyoMetro.#{str}" }
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    railways.include?( timetable.railway )
  } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141114_1856 銀座線の稲荷町駅 (Inaricho) とそれ以降（アルファベット）の時刻表を追加
def db_add_train_times_of_ginza_line_inaricho_and_later
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    timetable.railway == "odpt.Railway:TokyoMetro.Ginza" and  timetable.station >= "odpt.Station:TokyoMetro.Ginza.Inaricho"
  } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141115_0427 東西線、有楽町線の時刻表を追加
def db_add_train_times_of_ty
  timetables = ::TokyoMetro::Api.timetables
  railways = [ "Tozai" , "Yurakucho" ].map { | str | "odpt.Railway:TokyoMetro.#{str}" }
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    railways.include?( timetable.railway )
  } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141114_0258 千代田線以外の各路線の各駅の時刻表を追加
def db_add_train_times_of_stations_except_in_chiyoda_line
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable | timetable.railway != "odpt.Railway:TokyoMetro.Chiyoda" } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141114_0411 千代田線北千住駅の時刻表を追加
def db_add_train_times_of_chiyoda_line_kitasenju
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable | timetable.station == "odpt.Station:TokyoMetro.Chiyoda.KitaSenju" } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141115_0649 有楽町線の小竹向原 (KotakeMukaihara) とそれ以降（アルファベット）の時刻表を追加
def db_add_train_times_of_yurakucho_koteke_mukaihara_and_later
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    timetable.railway == "odpt.Railway:TokyoMetro.Yurakucho" and  timetable.station >= "odpt.Station:TokyoMetro.Yurakucho.KotakeMukaihara"
  } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141115_0702 有楽町線の和光市 (Wakoshi) とそれ以降（アルファベット）の時刻表を追加
def db_add_train_times_of_yurakucho_wakoshi_and_later
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    timetable.railway == "odpt.Railway:TokyoMetro.Yurakucho" and  timetable.station >= "odpt.Station:TokyoMetro.Yurakucho.Wakoshi"
  } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141202_0759 半蔵門線の神保町 (Jimbocho) とそれ以降（アルファベット）の時刻表を追加
def db_add_train_times_of_hanzomon_jimbocho_and_later
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    timetable.railway == "odpt.Railway:TokyoMetro.Hanzomon" and  timetable.station >= "odpt.Station:TokyoMetro.Hanzomon.Jimbocho"
  } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141115_0159 南北線の目黒駅 (Meguro) とそれ以降（アルファベット）の時刻表を追加
def db_add_train_times_of_namboku_line_meguro_and_later
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    timetable.railway == "odpt.Railway:TokyoMetro.Namboku" and  timetable.station >= "odpt.Station:TokyoMetro.Namboku.Meguro"
  } )
  timetables_to_seed.seed
  return nil
end

#-------- 20141115_0333 南北線の白金台 (Shirokanedai) とそれ以降（アルファベット）の時刻表を追加
def db_add_train_times_of_namboku_line_shirokanedai_and_later
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_seed = timetables.class.new( timetables.select { | timetable |
    timetable.railway == "odpt.Railway:TokyoMetro.Namboku" and  timetable.station >= "odpt.Station:TokyoMetro.Namboku.Shirokanedai"
  } )
  timetables_to_seed.seed
  return nil
end