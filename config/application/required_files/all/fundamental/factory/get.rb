class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Get < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "get" )
  end

  def self.other_files
    Api.files
  end

end