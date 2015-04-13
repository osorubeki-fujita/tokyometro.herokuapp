# ファイルの情報を扱うクラス
class TokyoMetro::Factory::Save::Api::MetaClass::Group::FileInfo

  # Constructor
  # @param value_ary [::Array] データの配列（グループ化されたハッシュの値）
  # @param key [String] データの ID キー（グループ化されたハッシュのキー）
  def initialize( value_ary , key )
    @list = value_ary
    @key = key
    puts filename
  end

  # @return [::Array] データの配列（グループ化されたハッシュの値から取得したもの）
  attr_reader :list
  # @param key [String] データの ID キー（グループ化されたハッシュのキー）
  attr_reader :key

  # 保存先のファイル名
  # @return [String (filename)]
  def filename
    set_filename_according_to_settings( delete_top_of_key( @key ) ).gsub( /\./ , "\/" )
  end

  # ファイル名を作成する際に削除する部分を示す正規表現
  # @return [Regexp]
  # @example
  #   /\Aodpt\.Station\:/
  def self.regexp_indicating_deleted_part_of_value_and_used_when_determine_saved_file_name
    error_msg = [
      "Error: This class method \'#{ __method__ }\' is not defind yet in this class \'#{self.name}\'." ,
      "Please set a regexp that is indicating deleted part of value and is used when determine saved file name key name."
    ].join( "\n" )
    raise error_msg
  end

  private

  def delete_top_of_key( key )
    regexp = self.class.regexp_indicating_deleted_part_of_value_and_used_when_determine_saved_file_name
    raise "Error" unless regexp.instance_of?( ::Regexp )
    key.to_s.gsub( regexp , "" )
  end

  def set_filename_according_to_settings( str )
    raise "Error: The class method \'#{__method__}\' is not defined yet in this class \'#{ self.name }\'."
  end

end