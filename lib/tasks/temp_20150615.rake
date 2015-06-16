namespace :temp do

  task :update_connecting_railway_line_info_at_nakano_sakaue_20150617 => :environment do
    title = "update_connecting_railway_line_info_at_nakano_sakaue_20150617"
    ::TokyoMetro::Rake::Update::ConnectingRailwayLine::NakanoSakaue.update_connecting_railway_line( title , number_of_connecting_railway_line_infos_should_be: 2 , to_update: true )
  end

  task :update_connecting_railway_line_info_at_nakano_sakaue_20150615 => :environment do
    title = "update_connecting_railway_line_info_at_nakano_sakaue_20150615"
    factory = ::TokyoMetro::Rake::Update::ConnectingRailwayLine::NakanoSakaue.new( title , number_of_connecting_railway_line_infos_should_be: 1 , to_update: true )
    factory.update_connecting_railway_line
    factory.create_connecting_railway_line_info
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
