namespace :tokyo_metro do
  namespace :test do
    namespace :check do

      desc "確認 - 駅施設情報 大手町駅 エスカレーターの方向"
      task :escalator_direction_in_otemachi do
        system( "rspec -c test\\tokyo_metro\\escalator_direction_in_otemachi_spec.rb" )
      end

      desc "確認 - 駅施設情報 中野新橋駅 トイレ設置場所"
      task :located_area_of_toilet_in_nakano_shimbashi do
        system( "rspec -c test\\tokyo_metro\\located_area_of_toilet_in_nakano_shimbashi_spec.rb" )
      end

      desc "確認 - 列車時刻表 有楽町線 不正な値"
      task :invalid_trains_in_yurakucho_line do
        system( "rspec -c test\\tokyo_metro\\invalid_trains_in_yurakucho_line_spec.rb" )
      end

      desc "確認 - 駅時刻表・列車時刻表 南北線 武蔵小杉行き"
      task :musashi_kosugi_on_tokyu_meguro_line do
        system( "rspec -c test\\tokyo_metro\\check_station_infos_in_timetables\\musashi_kosugi_on_tokyu_meguro_line_spec.rb" )
      end

      desc "確認 - 駅時刻表・列車時刻表 有楽町線 和光市行き"
      task :wakoshi_on_yurakucho_line do
        system( "rspec -c test\\tokyo_metro\\check_station_infos_in_timetables\\wakoshi_on_yurakucho_line_spec.rb" )
      end

      desc "確認 - 駅時刻表・列車時刻表 副都心線 和光市行き"
      task :wakoshi_on_fukutoshin_line do
        system( "rspec -c test\\tokyo_metro\\check_station_infos_in_timetables\\wakoshi_on_fukutoshin_line_spec.rb" )
      end

      desc "確認 - 駅時刻表・列車時刻表 丸ノ内支線 中野坂上行き"
      task :nakano_sakaue_on_marunouchi_branch_line do
        system( "rspec -c test\\tokyo_metro\\check_station_infos_in_timetables\\nakano_sakaue_on_marunouchi_branch_line_spec.rb" )
      end

      desc "確認 - 運賃 丸ノ内支線各駅から・まで"
      task :fares_of_marunouchi_branch_line do
        system( "rspec -c test\\tokyo_metro\\fares_of_marunouchi_branch_line_spec.rb" )
      end

      namespace :train_timetable do
        namespace :output do
          desc "出力 - 有楽町線・副都心線の列車の基本情報"
          task :yf_dest => :load do
            STATIONS = ::Station.all.includes( :railway_line )
            ::TokyoMetro.set_constants( { train_timetable: true } )
            ::TokyoMetro::Test::Api::TrainTimetable.yurakucho_and_fukutoshin_line_trains
          end
        end
      end

    end
  end
end


__END__

module TokyoMetro

  module Test

    module BoundForMinamiKurihashi

      NAME_BASE = "MinamiKurihashi"
      NAME = "odpt.Station:Tobu.Nikko.#{NAME_BASE}"
      REGEXP = /#{NAME_BASE}\Z/

      def is_bound_for_minami_kurihashi?
        self == ::TokyoMetro::Test::BoundForMinamiKurihashi::NAME
      end

    end

  end

end


def check_station_time_and_train_times_of_a0501k_weekday_in_aoyama_itchome
  train_timetable = ::TokyoMetro::Api.train_timetables.hanzomon.find { | timetable |
    timetable.train_number == "A0501K" and timetable.operated_in_weekdays?
  }

  describe train_timetable , "terminal station" do
    before do
      @terminal_station = train_timetable.terminal_station
      class << @terminal_station
        include ::TokyoMetro::Test::BoundForMinamiKurihashi
      end
    end
    it "should be bound for Minami-kurihashi" do
      expect( @terminal_station ).to be_bound_for_minami_kurihashi
    end
    after do
      @terminal_station = nil
    end
  end

  station_timetable = ::TokyoMetro::Api.station_timetables.hanzomon.find { | timetable |
    timetable.same_as == "odpt.StationTimetable:TokyoMetro.Hanzomon.AoyamaItchome.Oshiage"
  }
  train_info = station_timetable.weekdays.find { | train | train.departure_time.hour == 5 and train.departure_time.min == 49 }

  describe train_info , "terminal station" do
    before do
      @terminal_station = train_info.terminal_station
      class << @terminal_station
        include ::TokyoMetro::Test::BoundForMinamiKurihashi
      end
    end
    it "should be bound for Minami-kurihashi" do
      expect( @terminal_station ).to be_bound_for_minami_kurihashi
    end
    after do
      @terminal_station = nil
    end
  end
end


check_station_time_and_train_times_of_a0501k_weekday_in_aoyama_itchome