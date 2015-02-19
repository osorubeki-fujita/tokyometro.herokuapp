class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Refinements < RailsTokyoMetro::Application::RequiredFiles

  # refinements
  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "refinements" )
  end

  def self.other_files
    Api.files
  end

end