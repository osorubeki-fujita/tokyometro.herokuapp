module TokyoMetro

  module Test

    module MusashiKosugiOnTokyuMeguroLine

      NAME_BASE = "MusashiKosugi"
      NAME = "odpt.Station:Tokyu.Meguro.#{NAME_BASE}"
      REGEXP = /#{NAME_BASE}\Z/

      def musashi_kosugi_on_tokyu_meguro_line?
        self == ::TokyoMetro::Test::MusashiKosugiOnTokyuMeguroLine::NAME
      end
      alias :is_musashi_kosugi_on_tokyu_meguro_line? :musashi_kosugi_on_tokyu_meguro_line?

    end

  end

end

def musashi_kosugi_on_tokyu_meguro_line
  check_station_of_each_train_in_station_and_train_timetables(
    :namboku_or_toei_mita ,
    ::TokyoMetro::Test::MusashiKosugiOnTokyuMeguroLine ,
    :be_musashi_kosugi_on_tokyu_meguro_line
  )
end