# 列車時刻表 odpt:TrainTimetable のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::TrainTimetable < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable

  def self.process( http_client , db_dir , file_type , generate_instance , to_inspect )
    super( http_client , db_dir , file_type , generate_instance , to_inspect )
  end

  # ディレクトリ、ファイル名の設定
  # @return [::Symbol or nil]
  def self.settings_for_dirname_and_filename
    :train_timetable
  end

  def self.regexp_for_filename
    /\Aodpt\.TrainTimetable\:/
  end

end