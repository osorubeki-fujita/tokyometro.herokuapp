# SCSS を処理する機能を集めたモジュール
module TokyoMetro::Scss

  # SCSS を処理するメソッド
  # @return [nil]
  def self.process_scss
    current_dir = Dir.pwd
    Dir.chdir( "#{File.dirname( __FILE__ )}/../../public/css" )
    system( "scss fundamental_settings.css.scss style.css" )
    Dir.chdir( current_dir )
    return nil
  end

end