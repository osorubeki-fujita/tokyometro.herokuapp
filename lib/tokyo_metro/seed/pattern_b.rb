module TokyoMetro::Seed::PatternB

  extend ActiveSupport::Concern

  module ClassMethods

    private

    #-------- TokyoMetro::Api.station_timetables
    #-------- TokyoMetro::Api.train_timetables

    def process_timetables(h)
      process_each_content( h , :timetables ,
        Proc.new {
          ::TokyoMetro::Api.station_timetables.seed
          ::TokyoMetro::Api.train_timetables.seed
          # ::TokyoMetro::ApiModules::TimetableModules.seed_station_train_time
        }
      )
    end

  end

end