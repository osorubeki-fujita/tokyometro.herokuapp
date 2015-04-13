class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::TrainLocation < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "train_location" )
  end

end