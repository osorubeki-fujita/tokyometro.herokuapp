# SCSS の color ファイルを作成・処理するための Factory Pattern Class
class TokyoMetro::Factories::Scss::Colors < TokyoMetro::Factories::Scss

  # Constructor
  # @param ary この Factory Pattern Class を呼び出すクラスのインスタンス（ハッシュ）の値の配列
  def initialize( ary )
    @list = ary
  end

  # @return [::Array] この Factory Pattern Class を呼び出すクラスのインスタンス（ハッシュ）の値の配列
  attr_reader :list

  # SCSS ファイルの作成
  # @return [nil]
  def generate_file
    sccs_color_filename = self.class.scss_filename
    ::FileUtils.mkdir_p( File.dirname( sccs_color_filename ) )
    generate_file__inspect( sccs_color_filename )

    File.open( sccs_color_filename , "w:utf-8" ) do | file |
      generate_file__sub( file )
    end
  end

=begin
  # ファイルを変換するメソッド
  # @param css_fundamental [Boolean] SCSS の fundamental ファイルを変換するか否かの設定
  # @param css_color [Boolean] SCSS の color ファイルを変換するか否かの設定
  # @return [nil]
  def convert_files( css_fundamental , css_color )
    if css_fundamental
      self.class.upper_namespace::Fundamental.convert_to_css_by_settings
    end
    if css_color
      self.class.convert_to_css_by_settings
    end
  end
=end

  # インポートするファイルのリスト
  # @return [::Array <String>]
  def self.imported_files
    [ "../common_mixins/rounded_square" ]
  end

  # 色の設定（具体的な SCSS コード）に include する mixin のリスト
  # @return [::Array <String>]
  def self.included_bg_mixins
    [ "rounded_square" ]
  end

  def self.color_const_name( info , suffix )
    "\$#{info.css_class_name}_#{ suffix.to_s }"
  end

  private

  def generate_file__inspect( sccs_color_filename )
    puts "Generate Scss"
    puts "  Scss: #{sccs_color_filename}"
    puts ""
  end

  # SCSS ファイルに内容を出力するメソッド
  def generate_file__sub( file )
    generate_file__set_charset( file )
    generate_file__import_other_file( file )
    generate_file__set_color_consts( file )
    generate_file__set_colors( file )
  end

  # 文字コードの設定を書き込むメソッド
  # @return [nil]
  def generate_file__set_charset( file )
    file.print( "\@charset \"utf-8\" \;" )
    file.print( "\n" )
  end

  # インポートするファイルの設定を書き込むメソッド
  # @return [nil]
  def generate_file__import_other_file( file )
    self.class.imported_files.each do | imported_file |
      file.print( "\@import \'#{imported_file}.scss\' \;" )
      file.print( "\n" )
    end
    file.print( "\n" )
  end

  # 色を表す定数を書き込むメソッド
  # @return [nil]
  def generate_file__set_color_consts( file )
    @list.each do | info |
      self.class.settings_of_method_name.each do | key , value |
        const_name = self.class.color_const_name( info , key )
        file.print( "#{const_name}\: #{info.__send__( value ) } \;" )
        file.print( "\n" )
      end
    end
    file.print( "\n" )
  end

  # 色の設定（具体的な SCSS コード）を書き込むメソッド
  # @return [nil]
  def generate_file__set_colors( file )
    @list.each do | info |
      contents = generate_file__content_for_each_color( info )
      file.print( contents )
      file.print( "\n" * 2 )
    end
  end

  # 色の設定（具体的な SCSS コード）の文字列を返すメソッド
  # @return [String]
  def generate_file__content_for_each_color( info )
    begin_str = "\.rounded_square_#{info.css_class_name} \{"
    end_str = "\}"

    str_ary = ::Array.new
    str_ary << begin_str

    self.class.settings_of_method_name.each_key do | key |
      case key
      when :color
        attribute = "color"
        const_name = self.class.color_const_name( info , key )
        str_ary << "  #{ attribute }\: #{const_name}\;"
      end
    end
    generate_file__content_for_each_color__add_included_info_to_str_ary( str_ary , info )

    str_ary << end_str

    return str_ary.join( "\n" )
  end

  # include する mixin を文字列の配列に追加するメソッド
  # @return [nil]
  def generate_file__content_for_each_color__add_included_info_to_str_ary( str_ary , info )
    self.class.included_bg_mixins.each do | mixin |
      str_ary << "  \@include #{ mixin }( #{ self.class.color_const_name( info , :bgcolor ) } ) \;"
    end
  end

  class << self

    # SCSS ファイルの名称
    # @return [String]
    def scss_filename
      super( "colors" )
    end

    # CSS ファイルの名称
    # @return [String]
    def css_filename
      super( "colors" )
    end

  end

end