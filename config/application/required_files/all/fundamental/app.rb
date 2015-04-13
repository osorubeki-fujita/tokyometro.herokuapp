class RailsTokyoMetro::Application::RequiredFiles::All::Fundamental::App < RailsTokyoMetro::Application::RequiredFiles

  def initialize
    super( set_all_files_under_the_top_namespace: false )
  end

  def self.top_file
    ::File.join( ::Rails.root , "lib" , "tokyo_metro" , "app" )
  end

  def self.other_files
    Renderer.files
  end

end