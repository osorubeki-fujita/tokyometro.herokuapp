namespace :temp do

  namespace :completed do

    task :train_type_color_infos_20150728_1 => :environment do

      train_type_infos = ::Train::Type::Info.all.to_a
      for i in 0..( train_type_infos.length - 1 )
        train_type_info = train_type_infos[i]
        color_info = ::Train::Type::ColorInfo.find_or_create_by( color: train_type_info.color , bgcolor: train_type_info.bgcolor )
        train_type_info.update( color_info_id: color_info.id )
      end

    end

    task :train_type_color_infos_20150728_2 => :environment do

      train_type_color_infos = ::Train::Type::ColorInfo.all.to_a
      for i in 0..( train_type_color_infos.length - 1 )
        train_type_color_info = train_type_color_infos[i]
        color_info_id = ::Design::Color::Info.find_or_create_by( hex_color: train_type_color_info.color ).id
        bgcolor_info_id = ::Design::Color::Info.find_or_create_by( hex_color: train_type_color_info.bgcolor ).id
        train_type_color_info.update( color_info_id: color_info_id , bgcolor_info_id: bgcolor_info_id )
      end

    end

    task :operator_color_infos_20150728 => :environment do
      operator_code_infos = ::Operator::CodeInfo.all.to_a
      for i in 0..( operator_code_infos.length - 1 )
        operator_code_info = operator_code_infos[i]
        color_info_id = ::Design::Color::Info.find_or_create_by( hex_color: operator_code_info.color ).id
        operator_code_info.update( color_info_id: color_info_id )
      end

    end

    task :railway_line_code_infos_20150728 => :environment do
      railway_line_code_infos = ::Railway::Line::CodeInfo.all.to_a
      for i in 0..( railway_line_code_infos.length - 1 )
        railway_line_code_info = railway_line_code_infos[i]
        color_info_id = ::Design::Color::Info.find_or_create_by( hex_color: railway_line_code_info.color ).id
        railway_line_code_info.update( color_info_id: color_info_id )
      end
    end

  end

end
