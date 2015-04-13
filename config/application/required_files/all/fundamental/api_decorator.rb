class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::ApiDecorator < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api_decorator" )
  end

end