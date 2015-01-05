# 駅時刻表の、列車の終着駅に関する情報を処理する機能を提供するモジュール
# @note API からの情報のカスタマイズ
# @note {::TokyoMetro::Api::StationTimetable::Info::Train::Info} に対する機能
module TokyoMetro::ApiModules::Customize::StationTimetable::ProcessInfoOfTerminalStation::Info::Train::Info

  # Constructor
  # @return [::TokyoMetro::Api::StationTimetable::Info::Train::Info]
  def initialize( departure_time , terminal_station , train_type ,
is_last , is_origin , car_composition , notes )
    super
    process_info_of_terminal_station
  end

  private

  # 終着駅の名称 (same_as) をカスタマイズするメソッド
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
  def process_info_of_terminal_station
    @terminal_station = ::TokyoMetro::ApiModules::TimetableModules::Common::Station.station_same_as_in_db( @terminal_station )
  end

end