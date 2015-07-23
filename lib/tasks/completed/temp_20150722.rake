namespace :temp do
  namespace :completed do

    desc "Update column of TwitterAccount"
    task :twitter_accounts_20150722 => :environment do
      infos = ::TwitterAccount.all.to_a
      for i in 0..( infos.length - 1 )
        info = infos[i]
        case info.operator_info_or_railway_line_info_type
        when "RailwayLine"
          info.update( operator_info_or_railway_line_info_type: "Railway::Line::Info" )
        when "Operator"
          info.update( operator_info_or_railway_line_info_type: "Operator::Info" )
        end
      end
      nil
    end

    desc "Add id_urn, geo_json, dc_date to ::Railway::Line;;Info"
    task :railway_line_infos_20150722 => :environment do
      ::TokyoMetro::set_api_constants( { railway_line: true } )
      static_railway_line_infos = ::TokyoMetro::Static.railway_line_infos.values

      static_railway_line_infos.each do | railway_line_info |
        railway_line_info_in_db = ::Railway::Line::Info.find_by( same_as: railway_line_info.same_as )
        raise "The info of '#{ railway_line_info.same_as }' does not exist in db." unless railway_line_info_in_db.present?
        i = railway_line_info.index_in_operator
        raise unless i.present?
        railway_line_info_in_db.update( index_in_operator: i )
      end


      ::TokyoMetro::Api.railway_lines.each do | railway_line_info |
        railway_line_info_in_db = ::Railway::Line::Info.find_by( same_as: railway_line_info.same_as )
        raise "The info of '#{ railway_line_info.same_as }' does not exist in db." unless railway_line_info_in_db.present?
        dc_date = railway_line_info.dc_date
        if dc_date.present?
          dc_date = ::Time.new( dc_date.year , dc_date.month , dc_date.day , dc_date.hour , dc_date.min , dc_date.sec , dc_date.zone )
        end
        railway_line_info_in_db.update( id_urn: railway_line_info.id_urn , geo_json: railway_line_info.geo_json , dc_date: dc_date )
      end

    end

  end
end
