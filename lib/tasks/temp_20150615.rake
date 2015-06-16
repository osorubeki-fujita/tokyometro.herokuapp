namespace :temp do

  task :update_connecting_railway_line_info_at_nakano_sakaue_20150615 => :environment do
    title = "update_connecting_railway_line_info_at_nakano_sakaue_20150615"
    puts title
    station_infos = {
      main: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.Marunouchi.NakanoSakaue" ) ,
      branch: ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.MarunouchiBranch.NakanoSakaue" )
    }
    railway_lines = {
      main: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Marunouchi" ) ,
      branch: ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
    }

    station_infos.each do | k , station_info |
      raise "Error: #{ k }" unless station_info.present?
      raise "Error: #{ k }" unless station_info.connecting_railway_line_infos.length == 1
      raise "Error: #{ k }" unless station_info.connecting_railway_line_infos.first.railway_line.same_as == "odpt.Railway:Toei.Oedo"
    end
    railway_lines.each do | k , railway_line |
      raise "Error: #{ k }" unless railway_line.present?
    end

    station_infos.each do | k , station_info |
      puts "Update connecting railway line info to Oedo Line: #{k}"
      # station_info.connecting_railway_line_infos.first.update( index_in_station: 2 )
    end

    hashes_for_creating_connecting_railway_line_infos = [
      { station_info_id: station_infos[ :main ].id , railway_line_id: railway_lines[ :branch ].id , connecting_station_info_id: station_infos[ :branch ].id } ,
      { station_info_id: station_infos[ :branch ].id , railway_line_id: railway_lines[ :main ].id , connecting_station_info_id: station_infos[ :main ].id }
    ]

    hashes_for_creating_connecting_railway_line_infos.each do |h|
      h_for_create = h.merge({
        index_in_station: 1 ,
        connecting_to_another_station: false ,
        cleared: false ,
        not_recommended: false ,
        note_id: nil ,
        hidden_on_railway_line_page: true ,
        start_on: nil ,
        end_on: nil ,
        id: ::ConnectingRailwayLine::Info.all.pluck( :id ).max + 1
      })
      puts h_for_create
      ::ConnectingRailwayLine::Info.create( h_for_create )
    end
  end

  task :update_connecting_railway_line_info_at_ayase_20150615 => :environment do
    title = "update_connecting_railway_line_info_at_ayase_20150615"
    puts title

    ayase_branch = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase" )
    chiyoda_main = ::RailwayLine.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )
    jr_joban = ::RailwayLine.find_by( same_as: "odpt.Railway:JR-East.Joban" )

    connecting_railway_line_info_of_chiyoda_main = ayase_branch.connecting_railway_line_infos.find_by( railway_line_id: chiyoda_main.id )
    connecting_railway_line_info_of_jr_joban = ayase_branch.connecting_railway_line_infos.find_by( railway_line_id: jr_joban.id )
    raise "Error" unless connecting_railway_line_info_of_chiyoda_main.present?
    puts "Update"
    puts connecting_railway_line_info_of_chiyoda_main.inspect
    puts connecting_railway_line_info_of_jr_joban.inspect
    connecting_railway_line_info_of_chiyoda_main.update( hidden_on_railway_line_page: true )
    connecting_railway_line_info_of_jr_joban.update( hidden_on_railway_line_page: true )
  end

end
