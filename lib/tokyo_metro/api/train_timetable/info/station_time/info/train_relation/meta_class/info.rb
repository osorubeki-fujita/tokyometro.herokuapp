class TokyoMetro::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable
  include ::TokyoMetro::ClassNameLibrary::Api::StationTrainTime::Db
  include ::TokyoMetro::Modules::Common::ToFactory::Seed::Info

  def initialize( same_as , cars = :all )
    @same_as = same_as
    @cars = cars
  end

  attr_reader :cars
  attr_reader :same_as

  def in_api
    train_timetable = ::TokyoMetro::Api.train_timetables.find { | item | item.same_as?( @same_as ) }
    raise "Error" unless train_timetable.present?
    return train_timetable
  end

end