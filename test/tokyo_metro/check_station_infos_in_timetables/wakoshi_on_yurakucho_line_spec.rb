require_relative '../fundamental_settings.rb'
require_relative '../check_station_infos_in_timetables.rb'

::TokyoMetro.set_api_constants( { station_timetable: true , train_timetable: true } )

module TokyoMetro

  module Test

    module WakoshiOnYurakuchoLine

      NAME_BASE = "Wakoshi"
      NAME = "odpt.Station:TokyoMetro.Yurakucho.#{NAME_BASE}"
      REGEXP = /#{NAME_BASE}\Z/

      def wakoshi_on_yurakucho_line?
        self == ::TokyoMetro::Test::WakoshiOnYurakuchoLine::NAME
      end
      alias :is_wakoshi_on_yurakucho_line? :wakoshi_on_yurakucho_line?

    end
  
  end

end

def wakoshi_on_yurakucho_line
  check_station_of_each_train_in_station_and_train_timetables(
    :yurakucho ,
    ::TokyoMetro::Test::WakoshiOnYurakuchoLine ,
    :be_wakoshi_on_yurakucho_line
  )
end

wakoshi_on_yurakucho_line