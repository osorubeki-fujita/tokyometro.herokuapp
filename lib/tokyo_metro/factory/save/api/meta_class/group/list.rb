# グループ化されたデータの配列
class TokyoMetro::Factory::Save::Api::MetaClass::Group::List < Array

  # 配列内の各データを保存するメソッド
  # @param db_dir [String (dirname) or Const (Class)] 「データベースのディレクトリを示す文字列」または「クラスを表す定数」
  # @param file_type [Symbol or nil] 保存するファイルの種類
  # @note
  #  db_dir を定義しない場合は、このモジュールが組み込まれたクラスのクラスメソッド db_dirname を呼び出す。
  #  また、クラスを表す定数が指定された場合は、指定されたクラスのクラスメソッド db_dirname が呼び出される。
  # @return [nil]
  def save_datas( db_dir , file_type , instance_is_generated = false )
    unless self.empty?
      puts "○ #{self.length} files will be generated."
      save_datas__check_varidity

      factory = self.class.factory_for_saving_to_each_file

      _digit_of_length = digit_of_length
      print_header( _digit_of_length )
      self.each.with_index(1) do | fileinfo , i |
        factory.process( fileinfo.list , fileinfo.filename , db_dir , nil , file_type )
        print_inspect_info( i , _digit_of_length )
      end
    else
      puts "○ No file will be generated."
    end

    puts "\n" * 2

    return nil
  end

  # 保存の際に使用する Factory Pattern クラス
  def self.factory_for_saving_to_each_file
    raise "Error: The class method \'#{__method__}\' is not defined yet in this class \'#{ self.name }\'."
  end

  private

  def print_header( _digit_of_length )
    puts( " " * ( _digit_of_length + 1 ) + ( 1..10 ).map { |i| i * ( division / 10 ) }.map { |i| i.to_s.rjust(10) }.join )
    print( division.to_s.rjust( _digit_of_length ) + " " )
  end

  def save_datas__check_varidity
    unless self.all? { |i| i.instance_of?( self.class.file_info_class_for_saving ) }
      raise "Error"
    end
  end

  def print_inspect_info( i , _digit_of_length )
    if ( _digit_of_length < 5 or i % rate == 0 )
      print( "*" )
      if i % division == 0 and !( self.length == i )
        print( "\n" )
        print( ( i + division ).to_s.rjust( _digit_of_length ) + " " )
      end
    end
  end

  def digit_of_length
    raise "Error" unless division % 10 == 0
    ( self.length + division ).to_s.length
  end

  def division
    if self.length >= 10000
      100 * rate
    else
      100
    end
  end

  def rate
    20
  end

end