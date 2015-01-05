# 路線情報 odpt:Railway のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::RailwayLine < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::RailwayLine

  def self.regexp_for_filename
    /\Aodpt\.Railway\:/
  end

end