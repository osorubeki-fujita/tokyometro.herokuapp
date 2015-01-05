# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::MlitStation < TokyoMetro::Factories::Api::GenerateFromHash::MlitRailwayLine

  include ::TokyoMetro::ClassNameLibrary::Api::MlitStation

  private

  def variables_of_mlit_datas
    [ @hash[ "mlit:stationName" ] , super ].flatten
  end

end