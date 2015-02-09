# 西武池袋線直通 各駅停車
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::Local < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "各駅停車" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Local.ToSeibu" )
  end

end