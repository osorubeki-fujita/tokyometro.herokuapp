module TokyoMetro::ClassNameLibrary::Api::StationTrainTime

  extend ::ActiveSupport::Concern

  module ClassMethods

    def info_class
      ::TokyoMetro::Api::StationTrainTime
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Api::StationTrainTime
    end

  end

end