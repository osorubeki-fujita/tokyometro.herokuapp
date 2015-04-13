class TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::Info < TokyoMetro::Factory::Seed::Api::MetaClass::Info

  include ::TokyoMetro::ClassNameLibrary::Api::TrainTimetable
  include ::TokyoMetro::ClassNameLibrary::Api::StationTrainTime::Db

  include ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass::OptionalInfos

  private

  def seed_main
    _db_instance = db_instance
    _db_instance.update( hash_for_updating_db )
  end

  def db_instance
    db_class.find_or_create_by( hash_to_db )
  end

  def method_name_for_db_instance_class
    :db_instance_class_of_train_relation
  end

  def hash_for_updating_db
    raise "#{self.class.name}\##{__method__} is not defined yet."
  end

  def related_train_id
    ::TrainTimetable.find_by( same_as: @info.same_as ).id
  end

end