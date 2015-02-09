# 西武池袋線直通 準急
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::SemiExpress < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::SeibuIkebukuro::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "準急" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.SemiExpress.ToSeibu" )
  end

end