class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Common < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "common" )
  end

end