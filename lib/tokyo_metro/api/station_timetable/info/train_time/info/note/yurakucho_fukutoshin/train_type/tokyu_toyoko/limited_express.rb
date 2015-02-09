# 東急東横線直通 特急
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::LimitedExpress < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "特急" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.LimitedExpress.ToTokyu" )
  end

end