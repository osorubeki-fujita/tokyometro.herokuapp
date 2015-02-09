# 西武池袋線に乗り入れたときの種別の情報を扱うクラス（メタクラス）
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::Fundamental < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::Fundamental

  # Constructor
  # @param train_type 種別の名称
  # @note 境界駅：小竹向原／路線名：西武
  def initialize( train_type , train_type_in_db )
    super( "小竹向原" , "西武" , train_type , train_type_in_db )
  end

  def railway_line_in_db
    ::RailwayLine.find_by_same_as( "odpt.Railway:Seibu.Ikebukuro" )
  end

  def railway_line_on_the_border_station_in_db
    ::RailwayLine.find_by_same_as( "odpt.Railway:Seibu.SeibuYurakucho" )
  end

end