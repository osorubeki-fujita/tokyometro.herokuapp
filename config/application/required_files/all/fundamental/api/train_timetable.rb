class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::TrainTimetable < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "train_timetable" )
  end

  def self.other_files
    Info.files
  end

end