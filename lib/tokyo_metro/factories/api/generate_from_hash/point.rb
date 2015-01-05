# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factories::Api::GenerateFromHash::Point < TokyoMetro::Factories::Api::GenerateFromHash::MetaClass::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]
    title = self.class.info_class::Title.generate_from_string_in_hash( @hash[ "dc:title" ] )

    geo_long = @hash[ "geo:long" ]
    geo_lat = @hash[ "geo:lat" ]
    region = @hash[ "ug:region" ]

    ug_floor = @hash[ "ug:floor" ]
    category_name = @hash[ "ugsrv:categoryName" ]
    unless category_name == "出入口"
      raise "Error"
    end

    [ id , title , geo_long , geo_lat , region , ug_floor , category_name ]
  end

end