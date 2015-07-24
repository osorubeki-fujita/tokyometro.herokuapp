namespace :temp do

  namespace :completed do

    desc "Add id_urn, geo_json, dc_date to ::Railway::Line::Info (0722)"
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

    desc "Add id_urn, geo_json, dc_date to ::Railway::Line::Info (0725)"
    task :railway_line_infos_20150725 => :environment do
      railway_line_infos_in_db = ::Railway::Line::Info.all.to_a
      for i in 0..( railway_line_infos_in_db.length - 1 )
        info = railway_line_infos_in_db[i]
        columns = [ :id_urn , :dc_date , :geo_json ]

        if columns.map { | column_name | info.send( column_name ) }.any?( &:present? )
          additional_info = ::Railway::Line::AdditionalInfo.find_or_create_by( info_id: info.id )

          h = ::Hash.new
          h[ :api_info ] = true
          h[ :id_urn ] = info.id_urn
          h[ :geo_json ] = info.geo_json
          if info.dc_date.present?
            h[ :dc_date ] = ::DateTime.parse( "2014-11-07 12:19:19.000000" )
          else
            h[ :dc_date ] = nil
          end

          additional_info.update(h)
        end
      end

      nil

    end

  end

end
