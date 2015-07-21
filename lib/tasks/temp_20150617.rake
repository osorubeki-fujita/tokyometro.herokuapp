namespace :temp do

  task :update_connecting_railway_line_info_at_nakano_sakaue_20150617_1 => :environment do
    title = "update_connecting_railway_line_info_at_nakano_sakaue_20150617_1"
    factory = ::TokyoMetro::Rake::Rails::Update::ConnectingRailwayLine::NakanoSakaue.new( title , number_of_connecting_railway_line_infos_should_be: 1 , to_update: true )
    factory.update_connecting_railway_line
    factory.create_connecting_railway_line_info
  end

  task :update_connecting_railway_line_info_at_nakano_sakaue_20150617_2 => :environment do
    title = "update_connecting_railway_line_info_at_nakano_sakaue_20150617_2"
    ::TokyoMetro::Rake::Rails::Update::ConnectingRailwayLine::NakanoSakaue.update_connecting_railway_line( title , number_of_connecting_railway_line_infos_should_be: 2 , to_update: true )
  end

  task :update_connecting_railway_line_info_at_ayase_20150617 => :environment do
    title = "update_connecting_railway_line_info_at_ayase_20150617"
    puts "* #{ title }"
    puts ""

    ayase_branch = ::Station::Info.find_by( same_as: "odpt.Station:TokyoMetro.ChiyodaBranch.Ayase" )
    chiyoda_main = ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.Chiyoda" )
    jr_joban = ::Railway::Line::Info.find_by( same_as: "odpt.Railway:JR-East.Joban" )

    connecting_railway_line_info_to_chiyoda_main = ayase_branch.connecting_railway_line_infos.find_by( railway_line_info_id: chiyoda_main.id )
    connecting_railway_line_info_to_jr_joban = ayase_branch.connecting_railway_line_infos.find_by( railway_line_info_id: jr_joban.id )
    raise "Error" unless connecting_railway_line_info_to_chiyoda_main.present?
    raise "Error" unless connecting_railway_line_info_to_jr_joban.present?

    puts "Update"
    puts connecting_railway_line_info_to_chiyoda_main.inspect
    puts connecting_railway_line_info_to_jr_joban.inspect

    connecting_railway_line_info_to_chiyoda_main.update( hidden_on_railway_line_page: true )
    connecting_railway_line_info_to_jr_joban.update( hidden_on_railway_line_page: true )
  end

  task :update_platform_transfer_info_at_nakano_sakaue_20150617 => :environment do
    nakano_sakaue = ::Station::Facility::Info.find_by( same_as: "odpt.StationFacility:TokyoMetro.NakanoSakaue" )

    raise unless nakano_sakaue.present?

    railway_line_infos = {
      main: ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.Marunouchi" ) ,
      branch: ::Railway::Line::Info.find_by( same_as: "odpt.Railway:TokyoMetro.MarunouchiBranch" )
    }
    oedo_line = ::Railway::Line::Info.find_by( same_as: "odpt.Railway:Toei.Oedo" )

    railway_line_infos.values.each do |v|
      raise unless v.present?
    end
    raise unless oedo_line.present?

    p_infos = nakano_sakaue.platform_infos
    raise unless p_infos.present?

    for_honancho_in_api_same_as = "odpt.RailDirection:TokyoMetro.Honancho"
    for_honancho_on_branch_line = ::Railway::Direction.find_by( railway_line_info_id: railway_line_infos[ :branch ] , in_api_same_as: for_honancho_in_api_same_as )
    raise unless for_honancho_on_branch_line.present?

    p_infos.each do | platform_info |
      if platform_info.railway_line_info_id == railway_line_infos[ :main ].id and platform_info.car_composition == 6
        t_infos = platform_info.transfer_infos
        if t_infos.present?

          t_infos.each do | transfer_info |
            if transfer_info.railway_line_info_id != oedo_line.id and transfer_info.railway_direction.try( :in_api_same_as ) == for_honancho_in_api_same_as
              transfer_info.update( railway_line_info_id: railway_line_infos[ :branch ].id , railway_direction_id: for_honancho_on_branch_line.id )
            end
          end

        end
      end
    end

  end

end
