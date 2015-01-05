# 駅情報 odpt:Station のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::Station < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::Station

  def self.regexp_for_filename
    /\Aodpt\.Station\:/
  end

end