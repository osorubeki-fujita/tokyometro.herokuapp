# HAML ファイルの処理に使用するメソッドを提供するモジュール
# @note 廃止
module TokyoMetro::Modules::Static::Hash::ProcessHaml

  # HAML ファイルを処理するメソッド
  # @return [nil]
  def process_haml_file
    Dir.chdir( ::TokyoMetro::HAML_DIR )
    html_filename = "#{ TokyoMetro::HTML_DIR }/#{ File.basename( haml_filename ) }".gsub( /\.haml\Z/ , "\.html" )
    ::FileUtils.mkdir_p( File.dirname( html_filename ) )
    puts "Convert Haml"
    puts "  Haml: #{haml_filename}"
    puts "  Html: #{html_filename}"
    puts ""

    system( "haml #{ haml_filename } #{ html_filename }" )
    return nil
  end

  private

  # HAML ファイルの名称
  # @return [String (filename)]
  def haml_filename
    "#{ TokyoMetro::HAML_DIR }/#{ filename_base }.haml"
  end

end