module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStation::Methods::Info

  private

  # @example
  #   (1) 三鷹
  #     カスタマイズ前："odpt.Station:JR-East.Chuo.Mitaka"
  #     カスタマイズ後："odpt.Station:JR-East.ChuoTozai.Mitaka"
  #   (2) 津田沼
  #     カスタマイズ前："odpt.Station:JR-East.ChuoChikatetsuTozai.Tsudanuma"
  #     カスタマイズ後："odpt.Station:JR-East.SobuTozai.Tsudanuma"
  #   (3) 箱根湯本
  #     カスタマイズ前："odpt.Station:Odakyu.Odawara.HakoneYumoto"
  #     カスタマイズ後："odpt.Station:HakoneTozan.Rail.HakoneYumoto"
  #   (4) 竹ノ塚
  #     カスタマイズ前："odpt.Station:Tobu.Isesaki.Takenotsuka"
  #     カスタマイズ後："odpt.Station:Tobu.SkyTree.Takenotsuka"
  #   (5) 北越谷
  #     カスタマイズ前："odpt.Station:Tobu.Isesaki.KitaKoshigaya"
  #     カスタマイズ後："odpt.Station:Tobu.SkyTree.KitaKoshigaya"
  #   (6) 北春日部
  #     カスタマイズ前："odpt.Station:Tobu.Isesaki.KitaKasukabe"
  #     カスタマイズ後："odpt.Station:Tobu.SkyTree.KitaKasukabe"
  #   (7) 東武動物公園
  #     カスタマイズ前："odpt.Station:Tobu.Isesaki.TobuDoubutuKouen"
  #     カスタマイズ後："odpt.Station:Tobu.SkyTree.TobuDobutsuKoen"
  #   (8) 元町・中華街
  #     カスタマイズ前："odpt.Station:Minatomirai.Minatomirai.MotomachiChukagai"
  #     カスタマイズ後："odpt.Station:YokohamaMinatomiraiRailway.Minatomirai.MotomachiChukagai"
  def customized_station_name( name_in_api , title = nil )
    ::TokyoMetro::Modules::Common::Dictionary::Station.station_same_as_in_db( name_in_api , title )
  end

end