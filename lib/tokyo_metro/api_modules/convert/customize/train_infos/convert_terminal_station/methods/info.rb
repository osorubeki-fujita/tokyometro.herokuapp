module TokyoMetro::ApiModules::Convert::Customize::TrainInfos::ConvertTerminalStation::Methods::Info

  private

  # 終着駅の名称 (same_as) をカスタマイズするメソッド
  def customize_terminal_station_same_as_in_db
    @terminal_station = ::TokyoMetro::CommonModules::Dictionary::Station.station_same_as_in_db( @terminal_station , "Terminal station" )
  end

end