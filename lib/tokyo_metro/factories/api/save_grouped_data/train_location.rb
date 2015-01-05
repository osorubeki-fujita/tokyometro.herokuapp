# 列車運行情報 odpt:TrainInformation のデータを保存するためのクラス
class TokyoMetro::Factories::Api::SaveGroupedData::TrainLocation < TokyoMetro::Factories::Api::SaveGroupedData::MetaClass

  include ::TokyoMetro::ClassNameLibrary::Api::TrainLocation

  # Constructor
  def initialize( railway_line , db_dir , file_type , generate_instance , to_inspect )
    @railway_line = railway_line
    super( db_dir , file_type , generate_instance , to_inspect )
  end

  def get_and_set_data( http_client )
    ary = self.class.toplevel_namespace.get( http_client , @railway_line , perse_json: true , generate_instance: @generate_instance , to_inspect: @to_inspect )
    raise "Error" unless ary.kind_of?( ::Array )
    @data = ary
  end

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