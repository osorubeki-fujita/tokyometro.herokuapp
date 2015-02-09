# 鉄道路線の情報に関する SCSS の color ファイルを作成・処理するための Factory Pattern Class
class TokyoMetro::Factories::Scss::RailwayLines::Colors < TokyoMetro::Factories::Scss::Colors

  include ::TokyoMetro::Factories::Scss::RailwayLines::DirnameSettings

  # インポートするファイルのリスト
  # @return [::Array <String>]
  def self.imported_files
    [ "../common_mixins/railway_line_code" ]
  end

  # SCSS ファイルを作成する際の設定
  # @return [Hash]
  def self.settings_of_method_name
    { bgcolor: :color_normal_web }
  end

  private

  # SCSS ファイルに内容を出力するメソッド
  # @return [nil]
  def generate_file__sub( file )
    # 文字コード、インポートするファイル、色を表す定数、色の設定（具体的な SCSS コード／路線色の角丸四角形）を書き込む
    super( file )
    # 路線コードを書き込む
    generate_file__set_railway_line_codes( file )
  end

  def generate_file__set_railway_line_codes( file )
    @list.each do | info |
      contents = generate_file__content_for_each_railway_line_code( info )
      file.print( contents )
      file.print( "\n" * 2 )
    end
  end

  def generate_file__content_for_each_railway_line_code( info )
    str_ary = ::Array.new

    # 開始
    str_ary << "\.#{info.css_railway_line_code_class_name} \{"

    included_code_settings = generate_file__included_railway_line_code_settings( info )
    included_code_settings.each do | included_setting |
      str_ary << "  \@include #{included_setting}\;"
    end

    # 終了
    str_ary << "\}"

    return str_ary.join( "\n" )
  end

  # include される mixin の設定
  def generate_file__included_railway_line_code_settings( info )
    ary = ::Array.new

    # 色の設定
    ary << generate_file__railway_line_code_color_settings( info )

    # 文字の設定
    info.railway_line_code_text_settings_for_scss.each do | setting |
      ary << setting
    end

    return ary
  end

  def generate_file__railway_line_code_color_settings( info )
    variables = ::Array.new
    variables << self.class.color_const_name( info , "bgcolor" )    
    if info.stroke_line_width_of_stroked_line_for_scss.number?
      variables << "#{info.stroke_line_width_of_stroked_line_for_scss}px"
    end
    info.included_scss_mixin_for_railway_line_code_shape + "( #{ variables.join( " , " ) } )"
  end

end