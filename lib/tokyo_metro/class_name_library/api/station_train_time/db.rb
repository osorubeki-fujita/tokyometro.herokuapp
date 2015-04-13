module TokyoMetro::ClassNameLibrary::Api::StationTrainTime::Db

  extend ::ActiveSupport::Concern

  module ClassMethods

    def db_instance_class_of_station_train_time
      ::StationTrainTime
    end

    def db_instance_class_of_train_relation
      ::TrainRelation
    end

    def factory_for_seeding_previous_train_relation_list
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Previous::List
    end

    def factory_for_seeding_previous_train_relation_info
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Previous::Info
    end

    def factory_for_seeding_following_train_relation_list
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Following::List
    end

    def factory_for_seeding_following_train_relation_info
      ::TokyoMetro::Factory::Seed::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::Following::Info
    end

  end

end