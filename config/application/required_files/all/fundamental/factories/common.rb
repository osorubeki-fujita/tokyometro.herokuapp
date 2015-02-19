class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Common < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "common" )
  end

end