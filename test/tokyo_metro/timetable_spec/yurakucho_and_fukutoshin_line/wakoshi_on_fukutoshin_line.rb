module TokyoMetro

  module Test

    module WakoshiOnFukutoshinLine

      NAME_BASE = "Wakoshi"
      NAME = "odpt.Station:TokyoMetro.Fukutoshin.#{NAME_BASE}"
      REGEXP = /#{NAME_BASE}\Z/

      def wakoshi_on_fukutoshin_line?
        self == ::TokyoMetro::Test::WakoshiOnFukutoshinLine::NAME
      end
      alias :is_wakoshi_on_fukutoshin_line? :wakoshi_on_fukutoshin_line?

    end

  end

end

def wakoshi_on_fukutoshin_line
  check_station_of_each_train_in_station_and_train_timetables(
    :fukutoshin ,
    ::TokyoMetro::Test::WakoshiOnFukutoshinLine ,
    :be_wakoshi_on_fukutoshin_line
  )
end