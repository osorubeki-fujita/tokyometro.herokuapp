class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::StationTrainTime < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "station_train_time" )
  end

end