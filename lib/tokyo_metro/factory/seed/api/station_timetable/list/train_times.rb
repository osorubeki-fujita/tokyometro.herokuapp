class TokyoMetro::Factory::Seed::Api::StationTimetable::List::TrainTimes < TokyoMetro::Factory::Seed::Api::MetaClass::List

  include ::TokyoMetro::ClassNameLibrary::Api::StationTimetable

  private

  def set_optional_variables( args )
    set_optional_variables__check_length_of_args( args , 1 )
    @train_timetables = args.first
  end

  def optional_variables
    [ @train_timetables ]
  end

  def method_for_seeding_each_item
    :seed_train_times
  end

end