# 列車運行情報 odpt:TrainInformation のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::TrainInformation < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::TrainInformation

  # ディレクトリ、ファイル名の設定
  # @return [::Symbol or nil]
  def self.settings_for_dirname_and_filename
    :date
  end

    # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
  def self.method_name_when_instance_is_generated
    :railway_line
  end

  # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
  # @return [String or Symbol]
  def self.key_name_when_determine_dir
    "odpt:railway"
  end

  def self.regexp_for_filename
    /\Aodpt\.Railway\:/
  end

end