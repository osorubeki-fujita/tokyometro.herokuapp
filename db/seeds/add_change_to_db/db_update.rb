__END__

def db_update_to_station_info_id_of_namboku_line_train_bound_for_musashi_kosugi
  train_times = ::TrainTime.where( id: db_train_time_ids_of_namboku_line_bound_for_musashi_kosugi )
  to_station_info_id_of_meguro_musashi_kosugi = ::ToStation::Info.find_by( station_info_id: ::Station::Info.find_by( same_as: "odpt.Station:Tokyu.Meguro.MusashiKosugi" ).id ).id
  train_times.each do | train_time |
    train_time.update( to_station_info_id: to_station_info_id_of_meguro_musashi_kosugi )
  end
end

def reset_train_types_20141118_0608
  ::TrainTypeInApi.all.each do |d|
    d.destroy
  end
  TokyoMetro::StaticDatas.train_types_in_api.seed
  ::TrainTypeInApi.all.each.with_index(1) do | d , i |
    d.update( id: i )
  end

  ::TrainType.all.each do |d|
    d.destroy
  end
  TokyoMetro::StaticDatas.train_types.seed
  ::TrainType.all.each.with_index(1) do | d , i |
    d.update( id: i )
  end
end
