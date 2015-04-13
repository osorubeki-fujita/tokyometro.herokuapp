# グループ化されたデータを保存するためのクラス（メタクラス）
class TokyoMetro::Factory::Save::Api::MetaClass::Group

  # Constructor
  def initialize( db_dir , file_type , generate_instance , to_inspect )
    @db_dir = db_dir
    @file_type = file_type

    @generate_instance = generate_instance
    @to_inspect = to_inspect
  end

  attr_reader :db_dir
  attr_reader :file_type

  def get_and_set_data( http_client )
    @data = self.class.toplevel_namespace.get( http_client , perse_json: true , generate_instance: @generate_instance , to_inspect: @to_inspect )
  end

  # （JSON から生成した）インスタンスが与えられているか否かを判定するメソッド
  # @return [Boolean]
  def instance_will_be_generated?
    @generate_instance
  end

  # データの保存に必要なインスタンス（配列）を返すメソッド (1) - インスタンスメソッド
  # @return [::TokyoMetro::Factory::Save::Api::MetaClass::Group::List <FileInfo>]
  def to_data_list
    ary = self.class.list_class_for_saving_grouped_infos.new
    grouped_data.each do | key , value_ary |
      ary << self.class.file_info_class_for_saving.new( value_ary , key )
    end
    ary
  end

  # API の情報を取得し、ディレクトリに分けて保存するメソッド
  # @param http_client [HTTPClient] HTTPClient のインスタンス【必須】 
  # @note 可変長引数 必須の引数
  #   [TokyoMetro::Factory::Save::Api::TrainLocation::Group のみ]
  #     @param railway_line [String] 鉄道路線【必須】 <odpt:railway - odpt:Railway>
  #   [すべて]
  #   @param db_dir [String] 保存先のディレクトリの名称【必須】
  #   @param file_type [Symbol] 保存するファイルの種類【必須】
  #   @param generate_instance [Boolean] データ取得後に Ruby のインスタンスを作成するか否かの設定【必須】
  #   @param to_inspect [Boolean] データ取得後にコマンドツールに内容を表示するか否かの設定【必須】
  # @note このメソッドは、各クラスのクラスメソッド save_datas_of_each_group から呼び出される。
  # @return [nil]
  def self.process( http_client , *variables , display_inspect_info: true )
    info = self.new( *variables )
    info.get_and_set_data( http_client )
    ary = info.to_data_list
    ary.save_datas( info.db_dir , info.file_type )

    return nil
  end

  def self.list_class_for_saving_grouped_infos
    error_msg = [
      "Error: This class method \'#{ __method__ }\' is not defind yet in this class \'#{self.name}\'." ,
      "Please set an constant indicating sub-class of \'::TokyoMetro::Factory::Save::Api::MetaClass::Group::List\'."
    ].join( "\n" )
    raise error_msg
  end

  def self.file_info_class_for_saving
    error_msg = [
      "Error: This class method \'#{ __method__ }\' is not defind yet in this class \'#{self.name}\'." ,
      "Please set an constant indicating sub-class of \'::TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo\'."
    ].join( "\n" )
    raise error_msg
  end

  # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
  def self.method_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_generated
    error_msg = [
      "Error: This class method \'#{ __method__ }\' is not defind yet in this class \'#{self.name}\'." ,
      "Please set a symbol indicating method name."
    ].join( "\n" )
    raise error_msg
  end

  # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
  def self.key_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_not_generated
    error_msg = [
      "Error: This class method \'#{ __method__ }\' is not defind yet in this class \'#{self.name}\'." ,
      "Please set a string indicating hash key name."
    ].join( "\n" )
    raise error_msg
  end

  # ディレクトリ、ファイル名の設定
  # @return [::Symbol or nil]
  def self.settings_for_dirname_and_filename
    nil
  end

  private

  # @return [Hash]
  def grouped_data
    check_validity_before_grouping_data
    if instance_will_be_generated?
      grouped_data_when_instance_is_generated
    else
      grouped_data_when_instance_is_not_generated
    end
  end

  def check_validity_before_grouping_data
    if @data.nil?
      raise "Error"
    end
  end

  def grouped_data_when_instance_is_generated
    h = @data.group_by { | element_of_list |
      element_of_list.send( self.class.method_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_generated )
    }

    h_new = ::Hash.new
    h.each do | key , ary |
      h_new[ key ] = ary.map( &:to_h )
    end
    h_new
  end

  def grouped_data_when_instance_is_not_generated
    @data.group_by { | element_of_list |
      element_of_list[ self.class.key_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_not_generated ]
    }
  end

end