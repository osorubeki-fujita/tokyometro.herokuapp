class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Refinement < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "refinement" )
  end

  def self.other_files
    Api.files
  end

end