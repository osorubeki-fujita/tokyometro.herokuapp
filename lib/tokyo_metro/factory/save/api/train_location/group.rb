# 列車運行情報 odpt:TrainInformation のデータを保存するためのクラス
class TokyoMetro::Factory::Save::Api::TrainLocation::Group < TokyoMetro::Factory::Save::Api::MetaClass::Group

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

end