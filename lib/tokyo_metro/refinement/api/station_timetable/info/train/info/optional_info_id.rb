module TokyoMetro::Refinement::Api::StationTimetable::Info::TrainTime::Info::OptionalInfoId

  def starting_station_info_id( railway_line_ids )
    procedure = Proc.new { | note | note.kind_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::StartingStation::Fundamental ) }
    optional_info_id( procedure , railway_line_ids )
  end

  def arrival_info_id( railway_line_ids )
    procedure = Proc.new { | note | note.instance_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ArriveAt ) }
    optional_info_id( procedure , railway_line_ids )
  end

  def connection_info_id( railway_line_ids )
    procedure = Proc.new { | note | note.kind_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::ConnectionInfo ) }
    optional_info_id( procedure , railway_line_ids )
  end

  def train_type_in_other_operator_id
    procedure = Proc.new { | note | note.kind_of?( ::TokyoMetro::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukusohin::TrainType::Fundamental ) }
    optional_info_id( procedure )
  end

  def optional_info_id( procedure , railway_line_ids = nil )
    note = @notes.find( &procedure )
    if note.nil?
      nil
    else
      if railway_line_ids.present?
        note.seed_and_get_id( railway_line_ids )
      else
        note.seed_and_get_id
      end
    end
  end

end