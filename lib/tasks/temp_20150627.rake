# coding: utf-8

namespace :temp do
  task :operation_day_info_20150627 => :environment do
    ::TokyoMetro::Static.operation_days.each do | day_info |
      in_db = ::OperationDay.find_by( name_en: day_info.name_en )
      raise unless in_db.present?
      raise unless day_info.same_as.present?
      in_db.update( same_as: day_info.same_as )
    end
  end
end
