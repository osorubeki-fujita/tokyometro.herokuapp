class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukutoshin::KotakeMukaihara < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: true )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_timetable" , "info" , "train_time" , "info" , "note" , "yurakucho_fukutoshin" , "kotake_mukaihara" )
  end

end