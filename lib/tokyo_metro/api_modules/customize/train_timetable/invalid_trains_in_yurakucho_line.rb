module TokyoMetro::ApiModules::Customize::TrainTimetable::InvalidTrainsInYurakuchoLine

  LIST = ::YAML.load_file( "#{ ::TokyoMetro::DICTIONARY_DIR }/additional_datas/processing_errors/train_timetables_of_yurakucho_and_fukutoshin_line.yaml" )

end