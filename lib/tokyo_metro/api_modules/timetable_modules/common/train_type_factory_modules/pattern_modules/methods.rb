module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::PatternModules::Methods

  private

  def match_fundamental( train_type_same_as ,  railway_line_id , terminal_station_id , operation_day_id )
    train_type_is?( train_type_same_as ) and railway_line_is?( railway_line_id ) and terminal_station_is?( terminal_station_id ) and operation_day_is?( operation_day_id )
  end

  def train_type_is?( train_type_same_as )
    self[ :train_type_same_as ] == train_type_same_as
  end

  def railway_line_is?( railway_line_id )
    self[ :railway_line_id ] == railway_line_id
  end

  def terminal_station_is?( terminal_station_id )
    self[ :terminal_station_id ] == terminal_station_id
  end

  def operation_day_is?( operation_day_id )
    self[ :operation_day_id ] == operation_day_id
  end

end