module TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::Common

  private

  def train_type_id_in_db( railway_line_instance , terminal_station_instance , operation_day_instance , station_instance )
    self.class.train_type_factory_class.id_in_db( @train_type , railway_line_instance , terminal_station_instance , operation_day_instance , station_instance )
  end

  def timetable_starting_station_info_id_in_db( railway_line_instance )
    procedure = Proc.new { | info | info.kind_of?( ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::StartingStation::Fundamental ) }
    timetable_info_in_db( procedure , railway_line_instance )
  end

  def timetable_arrival_info_id_in_db( railway_line_instance )
    procedure = Proc.new { | info | info.instance_of?( ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::ArriveAt ) }
    timetable_info_in_db( procedure , railway_line_instance )
  end

  def timetable_connection_info_id_in_db( railway_line_instance )
    procedure = Proc.new { | info | info.kind_of?( ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::ConnectionInfo ) }
    timetable_info_in_db( procedure , railway_line_instance )
  end

  def timetable_train_type_in_other_operator_id_in_db
    procedure = Proc.new { | info | info.kind_of?( ::TokyoMetro::Api::StationTimetable::Info::Train::Info::Note::YurakuchoFukusohin::TrainType::Fundamental ) }
    timetable_info_in_db( procedure )
  end

  def timetable_info_in_db( procedure , railway_line_instance = nil )
    info = @notes.find( &procedure )
    if info.nil?
      nil
    else
      if railway_line_instance.present?
        info.seed_and_get_id( railway_line_instance )
      else
        info.seed_and_get_id
      end
    end
  end

end