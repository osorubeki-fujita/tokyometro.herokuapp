# 東武東上線に乗り入れたときの種別の情報を扱うクラス（メタクラス）
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TobuTojo::Fundamental < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::Fundamental

  # Constructor
  # @param train_type 種別の名称
  # @note 境界駅：和光市／路線名：東武東上
  def initialize( train_type , train_type_in_db )
    super( "和光市" , "東武東上" , train_type , train_type_in_db )
  end

  def railway_line_in_db
    ::RailwayLine.find_by_same_as( "odpt.Railway:Tobu.Tojo" )
  end

  alias :railway_line_on_the_border_station_in_db :railway_line_in_db

end