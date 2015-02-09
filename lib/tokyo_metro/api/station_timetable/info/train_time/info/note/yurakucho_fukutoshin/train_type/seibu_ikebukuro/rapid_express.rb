# 西武池袋線直通 快速急行
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::RapidExpress < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "快速急行" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.RapidExpress.ToSeibu" )
  end

end