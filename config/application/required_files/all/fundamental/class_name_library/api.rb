class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::ClassNameLibrary::Api < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "class_name_library" , "api" )
  end

  def self.other_files
    StationTrainTime.files
  end

end