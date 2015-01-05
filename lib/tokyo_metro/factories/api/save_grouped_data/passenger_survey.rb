# 駅乗降人員数 odpt:PassengerSurvey のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::PassengerSurvey < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::PassengerSurvey

    # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
  def self.method_name_when_instance_is_generated
    :survey_year
  end

  # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
  # @return [String or Symbol]
  def self.key_name_when_determine_dir
    "odpt:surveyYear"
  end

  def self.regexp_for_filename
    /\Aodpt\.PassengerSurvey\:/
  end

end