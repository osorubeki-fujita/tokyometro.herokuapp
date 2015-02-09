module TokyoMetro::Factories::Seed::Api::MetaClass::Timetables::TrainTypeModules::StartingStation

  include ::TokyoMetro::CommonModules::Info::Decision::StartingStation

  private

  def starting?( regexp )
    super( regexp , @starting_station_in_db.same_as )
  end

  alias :is_starting? :starting?
  alias :start? :starting?

end