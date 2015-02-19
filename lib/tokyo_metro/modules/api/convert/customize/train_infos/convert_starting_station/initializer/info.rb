# 列車の始発駅・終着駅に関する情報を処理する機能を提供するモジュール
# @note API からの情報のカスタマイズ
module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::ConvertStartingStation::Initializer::Info

  # Constructor
  # @return [::TokyoMetro::Api::TrainTimetable::Info]
  def initialize( *variables )
    super( *variables )
    customize_starting_station_same_as_in_db
  end

end