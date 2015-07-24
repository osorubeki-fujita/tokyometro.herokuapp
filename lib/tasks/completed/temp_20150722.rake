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
  end
end
