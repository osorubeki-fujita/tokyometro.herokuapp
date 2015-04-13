module TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::AdditionalInfos

  include ::TokyoMetro::Modules::Common::ConvertConstantToClassMethod

  [ :ignored_station_timetables , :replacing_infos ].each do | filename |
    const_set( filename.upcase , ::YAML.load_file( "#{::TokyoMetro.dictionary_dir}/additional_infos/customize/station_timetable/#{filename}.yaml" ) )
  end

  def self.set_modules
    ::TokyoMetro::Factory::Generate::Api::StationTimetable::List.class_eval do
      include ::TokyoMetro::Modules::Api::Convert::Customize::StationTimetable::AdditionalInfos::Generate::List
    end
  end

end