class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factories::Get::Api < RailsTokyoMetro::Application::RequiredFiles

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factories" , "get" , "api" )
  end

  def self.other_files
    MetaClass.files
  end

end