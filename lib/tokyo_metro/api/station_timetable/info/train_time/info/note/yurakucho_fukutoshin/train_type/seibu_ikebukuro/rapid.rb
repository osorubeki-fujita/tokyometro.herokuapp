# 西武池袋線直通 快速
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::Rapid < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "快速" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Rapid.ToSeibu" )
  end

end