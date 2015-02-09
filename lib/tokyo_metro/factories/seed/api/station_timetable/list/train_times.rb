class TokyoMetro::Factories::Seed::Api::StationTimetable::List::TrainTimes < TokyoMetro::Factories::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  private

  def set_optional_variables( args )
    raise "Error" unless args.length == 1
    @train_timetables = args.first
  end

  def optional_variables
    [ @train_timetables ]
  end

  def method_for_seeding_each_item
    :seed_train_times
  end

end