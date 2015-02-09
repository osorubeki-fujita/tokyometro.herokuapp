# 綾瀬始発
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation::Ayase < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "綾瀬" )
  end

end