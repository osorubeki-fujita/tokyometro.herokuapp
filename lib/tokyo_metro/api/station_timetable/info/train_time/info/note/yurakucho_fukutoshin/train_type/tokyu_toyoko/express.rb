# 東急東横線直通 急行
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::Express < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "急行" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Express.ToTokyu" )
  end

end