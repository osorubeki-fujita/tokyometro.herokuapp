class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  # static / 変化のない（or 非常に少ない）情報を扱うクラス
  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" )
  end

  def self.other_files
    [
      MetaClass.files ,
      fundamental_files ,
      Point.files ,
      RailwayLine.files ,
      Station.files ,
      StationFacility.files ,
      StationTrainTime.files ,
      StationTimetable.files ,
      TrainTimetable.files
    ]
  end

  class << self

    private

    def fundamental_files
      namespaces.map { | namespace |
        [
          ::File.join( top_file , namespace ) ,
          ::File.join( top_file , namespace , "info" ) ,
          ::File.join( top_file , namespace , "list" )
        ]
      }.flatten
    end

    def namespaces
      [
        "fare" , "mlit_railway_line" , "mlit_station" , "passenger_survey" , "point" , "railway_line" ,
        "station" , "station_facility" ,
        "train_information" , "train_location" ,
        "station_timetable" , "train_timetable"
      ]
    end

  end

end