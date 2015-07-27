namespace :temp do

  namespace :completed do

    task :railway_line_codes_20150725 => :environment do
      ::Railway::Line::CodeInfo.all.to_a.each do | item | ; item.destroy ; end
        ::Railway::Line::InfoCodeInfo.all.to_a.each do | item | ; item.destroy ; end


      railway_line_infos = ::Railway::Line::Info.all.to_a
      for i in 0..( railway_line_infos.length - 1 )
        railway_line_info = railway_line_infos[i]

        puts railway_line_info.same_as

        case railway_line_info.same_as
        when "odpt.Railway:Tobu.SkytreeIsesaki"

          code_1 = ::Railway::Line::CodeInfo.find_or_create_by( code: "TS" , color: "\#0f6cc3" )
          code_2 = ::Railway::Line::CodeInfo.find_or_create_by( code: "TI" , color: "\#ff0000" )
          [ code_1 , code_2 ].each.with_index(1) do | code_info , i |
            ::Railway::Line::InfoCodeInfo.find_or_create_by( info_id: railway_line_info.id , code_info_id: code_info.id , index: i )
          end

        else
          if railway_line_info.codes.present?
            raise "Error" unless  railway_line_info.codes.split("/").length == 1
          end

          code = railway_line_info.codes
          color_info = railway_line_info.color

          unless color_info.present?
            color_info = nil
          end

          unless code.present?
            code = nil
          end

          code_new = ::Railway::Line::CodeInfo::find_or_create_by( code: code , color: color_info )
          ::Railway::Line::InfoCodeInfo.find_or_create_by( info_id: railway_line_info.id , code_info_id: code_new.id , index: 1 )
        end

      end

    end

  end

end
