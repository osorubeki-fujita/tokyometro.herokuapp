# 東武東上線直通 各駅停車
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TobuTojo::Local < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TobuTojo::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "各駅停車" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Local.ToTobuTojo" )
  end

end