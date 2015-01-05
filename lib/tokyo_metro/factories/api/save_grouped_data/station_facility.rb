# 駅施設情報 odpt:StationFacility のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::StationFacility < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::StationFacility

  # ディレクトリ、ファイル名の設定
  # @return [::Symbol or nil]
  def self.settings_for_dirname_and_filename
    :alphabet
  end

  def self.regexp_for_filename
    /\Aodpt\.StationFacility\:/
  end

end