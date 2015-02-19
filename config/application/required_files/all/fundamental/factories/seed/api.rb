class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Api < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "api" )
  end

  def self.other_files
    [
      MetaClass.files ,
      Station.files ,
      StationFacility.files ,
      StationTimetable.files ,
      TrainTimetable.files
    ]
  end

end