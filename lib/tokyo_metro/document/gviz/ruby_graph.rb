# Ruby のクラス図を生成するためのモジュール
module TokyoMetro::Document::Gviz::RubyGraph

  # 処理を行うメソッド
  # @param dot_file [Boolean] .dot ファイルの生成を行うか否かの設定
  # @return [nil]
  def self.process( dot_file: true )
    if dot_file
      make_dot_file
    end
    return nil
  end

  class << self

    private

    # .dot ファイルを生成するメソッド
    # @return [nil]
    def make_dot_file
      filename = "ruby_classes.dot"
      Dir.chdir( ::TokyoMetro.DEV_DIR ) do
        system( "yard graph --full --dependencies --verbose -f #{filename}" )
        File.rename( filename , "#{ ::TokyoMetro::Document::Gviz::DIRNAME }/#{filename}" )
      end
      return nil
    end
  end

end