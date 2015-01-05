class TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::Pattern < Struct.new( :pattern_id , :train_type_same_as , :railway_line_id , :terminal_station_id , :operation_day_id )

  include ::TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::PatternModules::Methods

  def match?( train_type_same_as ,  railway_line_id , terminal_station_id , operation_day_id )
    match_fundamental( train_type_same_as ,  railway_line_id , terminal_station_id , operation_day_id )
  end

end