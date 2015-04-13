# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::MlitStation::Info < TokyoMetro::Factory::Generate::Api::MlitRailwayLine::Info

  include ::TokyoMetro::ClassNameLibrary::Api::MlitStation

  private

  def variables_of_mlit_datas
    [ @hash[ "mlit:stationName" ] , super ].flatten
  end

end