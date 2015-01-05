module TokyoMetro::ApiModules::TimetableModules::Common::TrainTypeFactoryModules::TerminalStation

  include ::TokyoMetro::CommonModules::Decision::TerminalStation

  def bound_for?( *list_of_train_terminal_station )
    super( list_of_train_terminal_station , @terminal_station.same_as )
  end

  private

  # @param regexp_or_string [Regexp or String]
  def is_terminating?( regexp_or_string )
    super( regexp_or_string , @terminal_station_instance.same_as )
  end

end