namespace :temp do

  task :debug_kasumigaseki_and_ginza_20150608 => :environment do
    title = "debug_kasumigaseki_and_ginza_20150608"
    facilities = {
      kasumigaseki: [ "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.4" , "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.5" ] ,
      ginza: "odpt.StationFacility:TokyoMetro.Hibiya.Ginza.Inside.Escalator.2"
    }
    category = :barrier_free_facilities

    ::TokyoMetro::Rake::Debug::StationFacility.process( title , facilities , category )
  end

  task :update_station_facility_in_kasumigaseki_20150608 => :environment do
    title = "update_station_facility_in_kasumigaseki_20150608"
    facility_names = [
      "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.4" ,
      "odpt.StationFacility:TokyoMetro.Chiyoda.Kasumigaseki.Outside.Escalator.5"
    ]
    proc_for_deciding_invalidity = ::Proc.new { | pattern | !( pattern.operation_day.present? ) }

    info_for_updating = ::OperationDay.find_by( name_ja: "平日" )
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

end
