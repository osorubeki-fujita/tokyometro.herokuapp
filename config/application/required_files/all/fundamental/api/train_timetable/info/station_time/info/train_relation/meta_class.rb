class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::TrainTimetable::Info::StationTime::Info::TrainRelation::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "train_timetable" , "info" , "station_time" , "info" , "train_relation" , "meta_class" )
  end

  def self.other_files
    [ "list" , "info" ].map { | filename |
      ::File.join( top_file , filename )
    }
  end

end