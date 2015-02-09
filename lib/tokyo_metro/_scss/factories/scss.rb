# SCSS のファイルを作成・処理するための Factory Pattern Class などを格納する名前空間
class TokyoMetro::Factories::Scss

  # SCCS ファイルを CSS ファイルに変換するメソッド
  # @param scss_filename [String (filename)] SCCS ファイルの名称
  # @param css_filename [String (filename)] CSS ファイルの名称
  # @return [nil]
  def self.convert_to_css( scss_filename , css_filename )
    ::FileUtils.mkdir_p( File.dirname( css_filename ) )
    convert_to_css__inspect( scss_filename , css_filename )
    system( "scss #{ scss_filename.convert_yen_to_slash } #{ css_filename.convert_yen_to_slash }")

    return nil
  end

=begin
  # 与えられた設定に応じて SCSS ファイルを CSS ファイルに変換するメソッド
  # @param file_basename [::Array <String>] ファイル名を格納した配列
  # @note サブクラスで sccs_filename , css_filename が上書きされ、それに応じて引数の数も変わるため（0になることがある）、file_basename は可変長引数とする。
  # @return [nil]
  def self.convert_to_css_by_settings( *file_basename )
    self.convert_to_css( scss_filename( *file_basename ) , css_filename( *file_basename ) )
  end
=end

  class << self

    private

    def convert_to_css__inspect( scss_filename , css_filename )
      puts "Convert Scss"
      puts "  Scss: #{ scss_filename }"
      puts "  Css : #{ css_filename }"
      puts ""
    end

    # SCSS ファイルの名称
    # @param file_basename [String] ファイルの名称
    # @return [String]
    def scss_filename( file_basename )
      "#{::TokyoMetro::SCSS_DIR}/#{ scss_dir }/#{file_basename}.scss"
    end

    # CSS ファイルの名称
    # @param file_basename [String] ファイルの名称
    # @return [String]
    def css_filename( file_basename )
      "#{::TokyoMetro::CSS_DIR}/#{ css_dir }/#{file_basename}.css"
    end

  end

end