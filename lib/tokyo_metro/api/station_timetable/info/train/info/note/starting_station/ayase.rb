# 綾瀬始発
class TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::StartingStation::Ayase < TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::StartingStation::Fundamental

  include ::Singleton

  # Constructor
  def initialize
    super( "綾瀬" )
  end

end