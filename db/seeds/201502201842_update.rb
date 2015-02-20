open_day_of_ueno_tokyo = ::DateTime.new( 2015,3,14,3)
# open_day_of_ueno_tokyo = nil

connecting_railway_lines_h_ueno = ::Station.find_by_same_as( "odpt.Station:TokyoMetro.Hibiya.Ueno" ).connecting_railway_lines

connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Ginza" ).id ).update( index_in_station: 1 , cleared: false )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Yamanote" ).id ).update( index_in_station: 2 , cleared: false )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.KeihinTohoku" ).id ).update( index_in_station: 3 , cleared: true )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.UenoTokyo" ).id ).update( index_in_station: 4 , cleared: false , start_on: open_day_of_ueno_tokyo )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Takasaki" ).id ).update( index_in_station: 5 , cleared: false )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Utsunomiya" ).id ).update( index_in_station: 6 , cleared: false )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Joban" ).id ).update( index_in_station: 7 , cleared: false )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Shinkansen" ).id ).update( index_in_station: 8 , cleared: true )
connecting_railway_lines_h_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:Keisei.KeiseiMain" ).id ).update( index_in_station: 9 , cleared: false )

connecting_railway_lines_g_ueno = ::Station.find_by_same_as( "odpt.Station:TokyoMetro.Ginza.Ueno" ).connecting_railway_lines

connecting_railway_lines_g_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Hibiya" ).id ).update( index_in_station: 1 , cleared: false )
connecting_railway_lines_g_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Yamanote" ).id ).update( index_in_station: 2 , cleared: false )
connecting_railway_lines_g_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.KeihinTohoku" ).id ).update( index_in_station: 3 , cleared: true )
connecting_railway_lines_g_ueno.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.UenoTokyo" ).id ).update( start_on: open_day_of_ueno_tokyo )

connecting_railway_lines_m_tokyo = ::Station.find_by_same_as( "odpt.Station:TokyoMetro.Marunouchi.Tokyo" ).connecting_railway_lines

connecting_railway_lines_m_tokyo.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.UenoTokyo" ).id ).update( start_on: open_day_of_ueno_tokyo )

connecting_railway_lines_g_shimbashi = ::Station.find_by_same_as( "odpt.Station:TokyoMetro.Ginza.Shimbashi" ).connecting_railway_lines

connecting_railway_lines_g_shimbashi.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:Toei.Asakusa" ).id ).update( index_in_station: 1 , cleared: false )
connecting_railway_lines_g_shimbashi.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Yamanote" ).id ).update( index_in_station: 2 , cleared: true )
connecting_railway_lines_g_shimbashi.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.KeihinTohoku" ).id ).update( index_in_station: 3 , cleared: false )
connecting_railway_lines_g_shimbashi.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Tokaido" ).id ).update( index_in_station: 4 , cleared: false )
connecting_railway_lines_g_shimbashi.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.Yokosuka" ).id ).update( index_in_station: 5 , cleared: false )
connecting_railway_lines_g_shimbashi.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:JR-East.UenoTokyo" ).id ).update( index_in_station: 6 , cleared: false , start_on: open_day_of_ueno_tokyo )
connecting_railway_lines_g_shimbashi.find_by_railway_line_id( ::RailwayLine.find_by_same_as( "odpt.Railway:Yurikamome.Yurikamome" ).id ).update( index_in_station: 7 , cleared: false )

::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Ginza" ).update( twitter_widget_id: 532630018443059201 , twitter_account: "G_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Marunouchi" ).update( twitter_widget_id: 532630724893868032 , twitter_account: "M_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Hibiya" ).update( twitter_widget_id: 532631112032321536 , twitter_account: "H_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Tozai" ).update( twitter_widget_id: 532631565486923777 , twitter_account: "T_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Chiyoda" ).update( twitter_widget_id: 532631847792959489 , twitter_account: "C_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Yurakucho" ).update( twitter_widget_id: 532632847350112256 , twitter_account: "Y_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Hanzomon" ).update( twitter_widget_id: 532632130656825344 , twitter_account: "Z_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Namboku" ).update( twitter_widget_id: 532632503169724416 , twitter_account: "N_line_info" )
::RailwayLine.find_by_same_as( "odpt.Railway:TokyoMetro.Fukutoshin" ).update( twitter_widget_id: 532633227697991680 , twitter_account: "F_line_info" )

::Operator.find_by_same_as( "odpt.Operator:TokyoMetro" ).update( twitter_widget_id: 532627820543897600 , twitter_account: "tokyometro_info" )