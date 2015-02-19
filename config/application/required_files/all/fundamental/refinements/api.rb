class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Refinements::Api < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "refinements" , "api" )
  end

  def self.other_files
    StationTimetable.files
  end

end