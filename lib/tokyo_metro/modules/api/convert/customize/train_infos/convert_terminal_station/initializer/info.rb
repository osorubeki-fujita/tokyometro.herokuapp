# 列車の終着駅に関する情報を処理する機能を提供するモジュール
# @note API からの情報のカスタマイズ
module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertTerminalStation::Initializer::Info

  # Constructor
  def initialize( *variables )
    super( *variables )
    customize_terminal_station_same_as_in_db
  end

end