# グループ化された運賃 odpt:RailwayFare のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::Fare < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::Fare

  def self.regexp_for_filename
    /\Aodpt\.RailwayFare\:/
  end

end