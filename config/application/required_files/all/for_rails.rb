class RailsTokyoMetro::Application::RequiredFiles::All::ForRails < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "for_rails" )
  end

end