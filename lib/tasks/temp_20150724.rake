namespace :temp do

  namespace :completed do

    task :change_attributes_of_railway_line_infos_20150724 => :environment do

      infos = ::Railway::Line::Info.all.to_a

      for i in 0..( infos.length - 1 )
        info = infos[i]
        case info.same_as
        when /(?<=Seibu\.)Chichibu/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Chichibu/ , "SeibuChichibu")
        when /(?<=Seibu\.)Yurakucho/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Yurakucho/ , "SeibuYurakucho")
        when /(?<=Tobu\.)SkyTree/
          same_as_new = info.same_as.gsub( /(?<=Tobu¥.)SkyTree/ , "Skytree")
        else
          next
        end

        info.update( same_as: same_as_new )
      end

    end

    task :change_attributes_of_station_infos_20150724 => :environment do

      infos = ::Station::Info.all.to_a

      for i in 0..( infos.length - 1 )
        info = infos[i]
        case info.same_as
        when /(?<=Seibu\.)Chichibu/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Chichibu/ , "SeibuChichibu")
        when /(?<=Seibu\.)Yurakucho/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Yurakucho/ , "SeibuYurakucho")
        when /(?<=Tobu\.)SkyTree/
          same_as_new = info.same_as.gsub( /(?<=Tobu\.)SkyTree/ , "Skytree")
        else
          next
        end

        info.update( same_as: same_as_new )
      end

    end

    task :change_attributes_of_station_name_aliases_20150724 => :environment do

      infos = ::Station::NameAlias.all.to_a

      for i in 0..( infos.length - 1 )
        info = infos[i]
        case info.same_as
        when /(?<=Seibu\.)Chichibu/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Chichibu/ , "SeibuChichibu")
        when /(?<=Seibu\.)Yurakucho/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Yurakucho/ , "SeibuYurakucho")
        when /(?<=Tobu\.)SkyTree/
          same_as_new = info.same_as.gsub( /(?<=Tobu\.)SkyTree/ , "Skytree")
        else
          next
        end

        info.update( same_as: same_as_new )
      end

    end

    task :change_attributes_of_stopping_patterns_20150724 => :environment do

      infos = ::StoppingPattern.all.to_a

      for i in 0..( infos.length - 1 )
        info = infos[i]
        case info.same_as
        when /(?<=Seibu\.)Chichibu/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Chichibu/ , "SeibuChichibu")
        when /(?<=Seibu\.)Yurakucho/
          same_as_new = info.same_as.gsub( /(?<=Seibu\.)Yurakucho/ , "SeibuYurakucho")
        when /(?<=Tobu\.)SkyTree/
          same_as_new = info.same_as.gsub( /(?<=Tobu\.)SkyTree/ , "Skytree")
        else
          next
        end

        info.update( same_as: same_as_new )
      end

    end

  end

end
