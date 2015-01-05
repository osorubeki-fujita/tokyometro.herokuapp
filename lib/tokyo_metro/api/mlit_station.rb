# 国土交通省国土数値情報-鉄道::駅 を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/mlit#mlit:Station-国土交通省国土数値情報-鉄道::駅
# @note mlit:stationNameは、国土交通省国土数値地図に記載されている駅名である。
# @note ug:region が指し示すURLは、GeoJSON 取得用のURLとなる。取得には、アクセストークンの付与が必要である。
# @note 取得される GeoJSON は、駅構内に入線する路線の MultiLine String となる。
class TokyoMetro::Api::MlitStation < TokyoMetro::Api::MetaClass::Geo

  include ::TokyoMetro::ClassNameLibrary::Api::MlitStation

  # @!endgroup

  class << self

    private

    def get_test_title
      "Mlit Station"
    end

  end

end