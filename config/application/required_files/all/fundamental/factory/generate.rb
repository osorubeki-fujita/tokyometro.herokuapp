class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Factory::Generate < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "factory" , "generate" )
  end

  def self.other_files
    [ Api.files , Static.files ]
  end

end