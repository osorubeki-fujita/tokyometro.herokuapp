module TokyoMetro::Modules::Api::Convert::Customize::TrainTimetable::StartingStation::Info

  def initialize( *variables )
    super( *variables )
    set_starting_station
  end

  private

  def set_starting_station
    if @starting_station.nil?
      @starting_station = valid_list.first.station[ :departure ]
    end
  end

end