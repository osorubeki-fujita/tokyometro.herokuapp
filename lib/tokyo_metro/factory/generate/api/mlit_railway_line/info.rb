# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::MlitRailwayLine::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::MlitRailwayLine

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]

    geo_long = @hash[ "geo:long" ]
    geo_lat = @hash[ "geo:lat" ]
    region = @hash[ "ug:region" ]

    [ id , geo_long , geo_lat , region , variables_of_mlit_datas ].flatten
  end

  private

  def variables_of_mlit_datas
    mlit_operator_name = @hash[ "mlit:operatorName" ]
    mlit_railway_line_name = @hash[ "mlit:railwayName" ]

    [ mlit_operator_name , mlit_railway_line_name ]
  end

end