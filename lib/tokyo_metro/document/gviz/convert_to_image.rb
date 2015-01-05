# dot ファイルを変換して画像ファイルを生成するためのモジュール
module TokyoMetro::Document::Gviz::ConvertToImage

  # 処理を行うメソッド
  # @param include_ruby_classes [Boolean] Ruby のクラス図の生成を行うか否かの設定
  # @return [nil]
  # @note Ruby のクラス図の生成過程は非常に重いため、生成を行うか否かを設定できるようにしてある。
  def self.process( include_ruby_classes: false )
    Dir.chdir( ::TokyoMetro::Document::Gviz::DIRNAME ) do
      dot_files = Dir.glob( "**.dot" )
      unless include_ruby_classes
        dot_files = dot_files.select { | filename | /\Aruby_classes/ !~ filename }
      end
      puts ""
      dot_files.each do | dot_filename |
        png_filename = dot_filename.gsub( /\.dot\Z/ , ".png" )
        puts "Process dot file: #{ dot_filename.ljust(32) } => #{ png_filename }"
        system( "dot -Tpng #{ dot_filename } -o #{ png_filename }" )
      end
    end
  end

end