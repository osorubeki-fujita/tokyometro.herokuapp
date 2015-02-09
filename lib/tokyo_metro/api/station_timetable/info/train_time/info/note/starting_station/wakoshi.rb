# 和光市始発
class TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation::Wakoshi < TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "和光市" )
  end

end