# 東急東横線に乗り入れたときの種別の情報を扱うクラス（メタクラス）
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::Fundamental < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::Fundamental

  # Constructor
  # @param train_type 種別の名称
  # @note 境界駅：渋谷／路線名：東急東横
  def initialize( train_type , train_type_in_db )
    super( "渋谷" , "東急東横" , train_type , train_type_in_db )
  end

  def railway_line_in_db
    ::RailwayLine.find_by_same_as( "odpt.Railway:Tokyu.Toyoko" )
  end

  alias :railway_line_on_the_border_station_in_db :railway_line_in_db

end