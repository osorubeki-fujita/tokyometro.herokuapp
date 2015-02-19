class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Seed::Api::MetaClass < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "seed" , "api" , "meta_class" )
  end

  def self.other_files
    Timetables.files
  end

end