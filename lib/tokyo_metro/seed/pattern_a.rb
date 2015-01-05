module TokyoMetro::Seed::PatternA

  extend ActiveSupport::Concern

  module ClassMethods

    private

    # @note TokyoMetro::Api.station_timetables
    def process_timetables(h)
      process_each_content( h , :timetables ,
        Proc.new {
          ::TokyoMetro::Api.station_timetables.seed
        }
      )
    end

  end

end