# API から取得したハッシュからインスタンスを生成するための Factory Pattern のクラス（メタクラス）
class TokyoMetro::Factory::Generate::Api::Point::Info < TokyoMetro::Factory::Generate::Api::MetaClass::Info::Fundamental

  include ::TokyoMetro::ClassNameLibrary::Api::Point

  # Info クラスに送る変数のリスト
  # @return [::Array]
  def variables
    id = @hash[ "\@id" ]

    geo_long = @hash[ "geo:long" ]
    geo_lat = @hash[ "geo:lat" ]
    region = @hash[ "ug:region" ]
    ug_floor = @hash[ "ug:floor" ]

    [ id , title , geo_long , geo_lat , region , ug_floor , category_name ]
  end

  def title
    self.class.title_class.generate_from_hash( @hash[ "dc:title" ] )
  end

  def category_name
    str = @hash[ "ugsrv:categoryName" ]
    unless str == "出入口"
      raise "Error"
    end
    str
  end

end