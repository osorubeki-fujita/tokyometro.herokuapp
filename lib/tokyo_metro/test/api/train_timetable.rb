module TokyoMetro::Test::Api::TrainTimetable

  def self.yurakucho_and_fukutoshin_line_trains
    string_ary = ::Array.new
    railway_lines = [ :yurakucho , :fukutoshin ]
    operation_days = [ 
      [ :is_operated_on_weekdays? , "Weekday" ] ,
      [ :is_operated_on_saturdays_and_holidays? , "Holiday" ]
    ]

    railway_lines.each do | railway_line |
      operation_days.each do | method_name_for_determining_operation_day , operation_day_name |
        train_timetables_in_api = ::TokyoMetro::Api.train_timetables.send( railway_line ).select( &method_name_for_determining_operation_day ).sort_by( &:train_number )
        train_timetable_infos = train_timetables_in_api.map { | train | ::TokyoMetro::Test::Api::TrainTimetable::TrainInfo.new( train ) }

        # 行先などの基本情報でグループ化
        h = train_timetable_infos.group_by( &:output )

        # ヘッダーの出力
        make_header( string_ary , "#{ railway_line.to_s.capitalize } #{ operation_day_name }" )

        h.each.with_index(1) do | ( output , trains ) , i |
          string_ary << [ "Pattern number" , "#{ title } #{i}" ].join( "," * 4 )

          string_ary << output.split( "\n" ).map { | str |
            str = str.gsub( /\A([\w ]+)\:/ ) { "#{ $1 }" + "," * 4 }
            str = str.gsub( "元町・中華街" , "元町中華街" )
            str = str.gsub( /（/ ) { ",（" }
            str
          }.join( "\n" )

          string_ary << [ "Trains" , trains.length.to_s ].join( "," * 4 )
          string_ary << ""
          string_ary << trains.map( &:train_number ).each_slice(10).to_a.map { | group | group.join( "," ) }
          string_ary <<  ""
        end
      end
    end

    str = string_ary.flatten.join( "\n" ).gsub( /[ \n]+\Z/ , "" ).encode( "windows-31j" )
    ::File.open( "#{ ::TokyoMetro::DEV_DIR }/document/result/yurakucho_and_fukutoshin_line.csv" , "w:windows-31j" ) do |f|
      f.print( str )
    end
  end

  class << self

    private

    def make_header( string_ary , title )
      n = 64
      # string_ary << "=" * n
      # string_ary << ""
      string_ary << title
      string_ary << ""
      # string_ary << "-" * n
      # string_ary << ""
    end

  end

end