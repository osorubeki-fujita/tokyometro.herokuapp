# 東急東横線直通 各駅停車
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::Local < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "各駅停車" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.Local.ToTokyu" )
  end

end