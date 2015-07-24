namespace :temp do
  namespace :completed do
    task :move_infos_to_operator_codes_20150725 => :environment do
      operator_infos = ::Operator::Info.all.to_a

      for i in 0..( operator_infos.length - 1 )
        info = operator_infos[i]
        h = ::Hash.new

        [ :railway_line_code_shape , :color , :station_code_shape ].each do | column_name |
          h[ column_name ] = info.send( column_name )
        end
        if info.operator_code.present?
          h[ :code ] = info.operator_code
        end
        if h[ :railway_line_code_shape ].blank?
          h[ :railway_line_code_shape ] = "none"
        end

        case info.same_as
        when "odpt.Operator:Seibu"
          h[ :railway_line_code_shape ] = "seibu"
          h[ :station_code_shape ] = "seibu_rounded_square"
        when "odpt.Operator:Yurikamome"
          h[ :railway_line_code_shape ] = "yurikamome_stroked_circle"
        end

        h.each do | k,v|
          if v.blank?
            h[k] = nil
          end
        end

        h[ :numbering ] = !!( info.numbering )

        ::Operator::Code.find_or_create_by( info_id: info.id ).update(h)
      end

    end
  end
end
