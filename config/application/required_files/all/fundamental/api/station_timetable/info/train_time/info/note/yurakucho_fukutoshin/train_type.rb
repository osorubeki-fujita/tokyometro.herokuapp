class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationTimetable::Info::TrainTime::Info::Note::YurakuchoFukutoshin::TrainType < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_timetable" , "info" , "train_time" , "info" , "note" , "yurakucho_fukutoshin" , "train_type" )
  end

  def self.other_files
    [
      ::Dir.glob( "#{ top_file }/**.rb" ).sort ,
      namespaces.map { | namespace |
        [
          ::File.join( top_file , namespace ) ,
          ::Dir.glob( "#{ top_file }/#{ namespace }/fundamental.rb" ).sort ,
          ::Dir.glob( "#{ top_file }/#{ namespace }/**.rb" ).sort
        ]
      }
    ]
  end

  class << self

    private

    def namespaces
      [ "fundamental" , "seibu_ikebukuro" , "tobu_tojo" , "tokyu_toyoko" ]
    end

  end

end