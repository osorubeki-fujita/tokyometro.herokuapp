namespace :temp do

  task :debug_akasaka_mitsuke_20150613 => :environment do
    title = "debug_akasaka_mitsuke_20150613"
    facilities = {
      akasaka_mitsuke: [ "odpt.StationFacility:TokyoMetro.Ginza.AkasakaMitsuke.Outside.Escalator.1" , "odpt.StationFacility:TokyoMetro.Marunouchi.AkasakaMitsuke.Outside.Escalator.1" ]
    }
    category = :barrier_free_facilities

    ::TokyoMetro::Rake::Debug::StationFacility.process( title , facilities , category )
  end

  task :update_service_detail_pattern_of_akasaka_mitsuke_20150613_1 => :environment do
    title = "update_service_detail_pattern_of_akasaka_mitsuke_20150613_1"
    facility_names = "odpt.StationFacility:TokyoMetro.Ginza.AkasakaMitsuke.Outside.Escalator.1"
    proc_for_deciding_invalidity = ::Proc.new { | pattern | !( pattern.operation_day.present? ) }

    info_for_updating = ::OperationDay.find_by( name_ja: "土日祝" )
    h_for_updating = {
      operation_day_id: info_for_updating.id
    }
    proc_for_creating_h_for_new_pattern_instance = ::Proc.new { | info_for_updating , invalid_pattern |
      h = {
        operation_day_id: info_for_updating.id ,
        service_start_before_first_train: invalid_pattern.service_start_before_first_train ,
        service_start_time_hour: invalid_pattern.service_start_time_hour ,
        service_start_time_min: invalid_pattern.service_start_time_min ,
        service_end_time_hour: invalid_pattern.service_end_time_hour ,
        service_end_time_min: invalid_pattern.service_end_time_min ,
        service_end_after_last_train: invalid_pattern.service_end_after_last_train
      }

      h
    }

    ::TokyoMetro::Rake::BugFix::BarrierFreeFacility::Pattern.process( title , facility_names , proc_for_deciding_invalidity , info_for_updating , h_for_updating , proc_for_creating_h_for_new_pattern_instance , to_test: false )
  end

  task :update_service_detail_pattern_of_akasaka_mitsuke_20150613_2 => :environment do
    BarrierFreeFacilityServiceDetail.where( barrier_free_facility_service_detail_pattern_id: 99 ).to_a.each do | item |
      item.update( barrier_free_facility_service_detail_pattern_id: 98 )
    end
    BarrierFreeFacilityServiceDetailPattern.find(99).destroy
  end

end
