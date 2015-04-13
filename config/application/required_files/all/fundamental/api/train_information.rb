class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::TrainInformation < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "train_information" )
  end

end