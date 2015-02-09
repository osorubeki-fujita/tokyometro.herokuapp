module TokyoMetro::ApiModules::Convert::Customize::StationTimetable::AdditionalInfos

  include ::TokyoMetro::CommonModules::ConvertConstantToClassMethod

  [ :ignored_station_timetables , :replacing_infos ].each do | filename |
    const_set( filename.upcase , ::YAML.load_file( "#{::TokyoMetro.dictionary_dir}/additional_infos/customize/station_timetable/#{filename}.yaml" ) )
  end

  def self.set_modules
    ::TokyoMetro::Factories::Generate::Api::StationTimetable::List.class_eval do
      include ::TokyoMetro::ApiModules::Convert::Customize::StationTimetable::AdditionalInfos::Generate::List
    end
  end

end