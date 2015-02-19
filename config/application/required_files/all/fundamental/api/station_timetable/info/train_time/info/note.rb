class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationTimetable::Info::TrainTime::Info::Note < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_timetable" , "info" , "train_time" , "info" , "note" )
  end

  def self.other_files
    [
      ::Dir.glob( "#{ top_file }/**.rb" ).sort ,
      ShirokaneTakanawa.files ,
      StartingStation.files ,
      YurakuchoFukutoshin.files
    ]
  end

end