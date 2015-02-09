# 国土交通省国土数値情報-鉄道::路線 を扱うクラス
# @see https://developer.tokyometroapp.jp/documents/mlit#mlit:Railway-国土交通省国土数値情報-鉄道::路線
# @note mlit:railwayNameは、国土交通省国土数値地図に記載されている線名である。
# @note ここでの ug:region が指し示すものは、GeoJSON 取得用のURLとなる。
class TokyoMetro::Api::MlitRailwayLine < TokyoMetro::Api::MetaClass::Geo

  include ::TokyoMetro::ClassNameLibrary::Api::MlitRailwayLine

  # @!group テスト

  # データ取得のテスト
  # @return [nil]
  def self.get_geo_test( http_client , geo_long , geo_lat , radius )
    puts "● #{ get_test_title } (geo)"
    result = get_geo( http_client , geo_long , geo_lat , radius , to_inspect: true , perse_json: true , generate_instance: true )
    puts "(#{ result.length })"
    result.sort_by( &:mlit_operator_name ).each do | item |
      puts item.to_strf
      puts "" * 2
    end
  end

  # @!endgroup

  class << self

    private

    def get_test_title
      "Mlit Railway Line"
    end

  end

end