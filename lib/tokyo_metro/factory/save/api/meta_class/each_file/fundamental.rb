# API から取得したデータなどを保存するための Factory Pattern クラス
class TokyoMetro::Factory::Save::Api::MetaClass::EachFile::Fundamental

  # Constructor
  # @param db_dir [String (dirname) or Const (Class)] 「データベースのディレクトリを示す文字列」または「クラスを表す定数」
  def initialize( data , filename = Time.now.strftime( "%Y%m%d" ) ,
    db_dir: nil ,
    dirname_sub: nil ,
    file_type: :yaml
  )
    check_validity_of_data( data )
    @data = data
    @filename = filename
    @db_dir = set_db_dirname( db_dir )
    @dirname_base = set_dirname_base( dirname_sub )
    @file_type = file_type
  end

  attr_reader :data , :filename , :db_dir , :dirname_base , :file_type

  def filename_fullpass
    if /[\.\/]/ === @filename
      splited_ary = @filename.split( /[\.\/]/ )
      filename = splited_ary.pop
      "#{ @dirname_base }\/#{ splited_ary.join( "\/" ) }\/#{ filename }"
    else
      "#{ @dirname_base }\/#{ @filename }"
    end
  end

  def save_to_file
    chdir_to_dir_of_file
    filename = File.basename( self.filename_fullpass )
    case @file_type
    when :txt
      save_as_txt( filename )
    when :json
      save_as_json( filename )
    when :yaml , :yml
      save_as_yaml( filename )
    else
      raise "Error"
    end
  end

  def self.process( data , filename , db_dir , dirname_sub , file_type )
    # puts "\n" * 2
    # puts "Begin Process"
    # puts "db_dir: #{ db_dir }"
    # puts "file_type: #{ file_type }"
    # puts ""

    info = self.new( data , filename , db_dir: db_dir , dirname_sub: dirname_sub , file_type: file_type )

    # puts "filename: #{ info.filename }"
    # puts "db_dir: #{ info.db_dir }"
    # puts "dirname_base: #{ info.dirname_base }"
    # puts "Fullpass: #{ info.filename_fullpass }"

    info.save_to_file
  end

  private

  def check_validity_of_data( data )
    unless data.instance_of?( Hash ) or data.instance_of?( ::Array )
      raise "Error: The data is not valid. (Class: #{data.class.name})"
    end
  end

  # 保存先のディレクトリの名称を返すメソッド
  # @note db_dir が「クラスを表す定数」である場合は、指定されたクラスのクラスメソッド db_dirname が呼び出される。それ以外の場合はインスタンス変数 db_dir を返す。
  def set_db_dirname( db_dir ) # set_db_base_dirname
    if db_dir.instance_of?( ::Class )
      str = db_dir.db_dirname
    else
      str = db_dir
    end
    raise "Error" if str.nil?
    str
  end

  def set_dirname_base( dirname_sub )
    if dirname_sub.nil?
      @db_dir
    elsif dirname_sub.string?
      "#{ @db_dir }\/#{ dirname_sub }"
    elsif dirname_sub.instance_of?( ::Array ) and dirname_sub.all?{ | element | element.string? }
      "#{ @db_dir }\/#{ dirname_sub.join( "\/" ) }"
    else
      raise "Error: The instance variable \"dirname_sub\" is not valid. (Class: #{ dirname_sub.class.name })"
    end
  end

  def chdir_to_dir_of_file
    dirname_l = File.dirname( self.filename_fullpass )
    unless Dir.pwd == dirname_l
      ::FileUtils.mkdir_p( dirname_l )
      Dir.chdir( dirname_l )
    end
  end

  def save_as_txt( filename )
    file = File.open( "#{filename}.txt" , "w:UTF-8" )
    file.print( @data.to_s )
    file.close
  end

  def save_as_json( filename )
    open( "#{filename}.json" , "w:UTF-8" ) do | f |
      ::JSON.dump( @data , f )
    end
  end

  def save_as_yaml( filename )
    open( "#{filename}.yaml" , "w:UTF-8" ) do | f |
      ::YAML.dump( @data , f )
      #YAML.unespace( @data , f )
    end
  end

end