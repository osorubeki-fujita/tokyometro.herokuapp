# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Generate::Api::MlitStation::Info < TokyoMetro::Factories::Generate::Api::MlitRailwayLine::Info

  include ::TokyoMetro::ClassNameLibrary::Api::MlitStation

  private

  def variables_of_mlit_datas
    [ @hash[ "mlit:stationName" ] , super ].flatten
  end

end