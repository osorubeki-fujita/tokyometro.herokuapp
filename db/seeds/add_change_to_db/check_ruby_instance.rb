#-------- 20141114_0407 千代田線北千住駅の駅時刻表（オリジナルの Ruby インスタンス）をチェック
def check_ruby_instance_of_chiyoda_line_kitasenju
  timetables = ::TokyoMetro::Api.timetables
  timetables_to_check = timetables.class.new( timetables.select { | timetable |
    timetable.railway == "odpt.Railway:TokyoMetro.Chiyoda" and timetable.station == "odpt.Station:TokyoMetro.Chiyoda.KitaSenju"
  })
  puts "Timetables to check: #{timetables_to_check.length}"

  indent = 4
  timetables_to_check.each do | timetable |
    puts timetable.same_as
    method_array = [ :weekdays , :saturdays , :holidays ]
    method_array.each do | method_name |
      puts " " * indent + method_name.to_s
      puts ""
      timetable.send( method_name ).each do | train_time |
        note = train_time.note
        if note.present?
          puts " " * indent * 2 + train_time.departure_time.to_s
          puts " " * indent * 2 + note.to_s
          puts ""
        end
      end
    end
  end
  return nil
end