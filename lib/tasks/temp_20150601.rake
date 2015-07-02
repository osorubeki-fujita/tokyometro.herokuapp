namespace :temp do

  desc "Replace invalid surrounding area info"
  task :surrounding_area_20150601 => :environment do
    toranomon_hospital_invalid = ::SurroundingArea.find_by( name: "虎ノ門病院" )
    toranomon_hospital_valid = ::SurroundingArea.find_by( name: "虎の門病院" )
    toranomon_hospital_invalid.station_facility_platform_info_surrounding_areas.each do | item |
      item.update( surrounding_area_id: toranomon_hospital_valid.id )
    end
    toranomon_hospital_invalid.destroy
  end

end
