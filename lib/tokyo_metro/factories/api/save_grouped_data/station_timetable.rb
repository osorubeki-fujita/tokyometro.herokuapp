# 駅時刻表 odpt:StationTimetable のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::StationTimetable < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  # ディレクトリ、ファイル名の設定
  # @return [::Symbol or nil]
  def self.settings_for_dirname_and_filename
    :station_timetable
  end

=begin
  # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
  # @return [String or Symbol]
  def self.method_name_when_instance_is_generated
    :station
  end

  # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
  # @return [String or Symbol]
  def self.key_name_when_determine_dir
    "odpt:station"
  end
=end

  def self.regexp_for_filename
    /\Aodpt\.StationTimetable\:/
  end

end