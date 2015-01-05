
__END__

# グループ化された国土交通省国土数値情報-鉄道::路線 mlit:Railway のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::MlitRailwayLine < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::MlitRailwayLine
  
  def self.regexp_for_filename
    /\mlit\.Railway\:/
  end

end