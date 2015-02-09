# 東急東横線直通 通勤特急
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::CommuterLimitedExpress < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::TokyuToyoko::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "通勤特急" , "custom.TrainType:TokyoMetro.YurakuchoFukutoshin.CommuterLimitedExpress.ToTokyu" )
  end

end