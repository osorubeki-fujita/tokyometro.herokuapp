namespace :temp do

  namespace :completed do

    task :operator_additional_infos_20150803 => :environment do
      ::TokyoMetro::Static.operators.values.each do | operator |
        operator_in_db = ::Operator::Info.find_by( same_as: operator.same_as )
        raise unless operator_in_db.present?
        operator_id = operator_in_db.id
        puts operator_id
        operator.additional_infos.seed( operator_id )
      end
    end

  end

end
