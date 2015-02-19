class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::Api::Point < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "api" , "point" )
  end

  def self.other_files
    ::File.join( top_file , "info" , "title" )
  end

end