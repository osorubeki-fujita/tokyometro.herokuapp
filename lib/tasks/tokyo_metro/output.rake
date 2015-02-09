namespace :tokyo_metro do
  namespace :output do

    desc "出力 - 有楽町線・副都心線の列車の基本情報"
    task :yf_dest => :load do
      STATIONS = ::Station.all.includes( :railway_line )
      ::TokyoMetro.set_constants( { train_timetable: true } )
      ::TokyoMetro::Test::Api::TrainTimetable.yurakucho_and_fukutoshin_line_trains
    end
  
  end
end