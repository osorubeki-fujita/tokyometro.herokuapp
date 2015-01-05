class TokyoMetro::ApiModules::TimetableModules::StationTimetable::Info::Train::Seed::PatternA::TrainTypeFactory::Pattern < Struct.new( :pattern_id , :train_type_same_as , :railway_line_id , :terminal_station_id , :operation_day_id , :station_id )

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::PatternModules::Methods

  def match?( train_type_same_as ,  railway_line_id , terminal_station_id , operation_day_id , station_id )
    match_fundamental( train_type_same_as ,  railway_line_id , terminal_station_id , operation_day_id ) and station_is?( station_id )
  end

  private

  def station_is?( station_id )
    self[ :station_id ] == station_id
  end

end